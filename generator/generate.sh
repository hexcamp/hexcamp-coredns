#! /bin/bash

# Uses: csvkit
# brew install csvkit
# https://csvkit.readthedocs.io/en/latest/

#set -euxo pipefail
set -euo pipefail

gen_new_file() {
  DIRNAME=$(dirname $1)
  BASENAME=$(basename $1)
  echo Generating: current/$DIRNAME/$BASENAME
  mkdir -p current/$DIRNAME
  if [ -f previous/$DIRNAME/$BASENAME ]; then
    SERIAL=$(cat previous/$DIRNAME/$BASENAME | sed -n -E 's,^[[:space:]]+([[:digit:]]+).*; serial,\1,p')
    if [ -z "$SERIAL" ]; then
      cp templates/$DIRNAME/$BASENAME current/$DIRNAME/$BASENAME
      return
    fi
  else
    DATE=$(date +"%Y%m%d")
    SERIAL="${DATE}01"
  fi
  REGION=$(echo $DIRNAME | sed -n -E 's,^.*zones/([^/]+)/.*,\1,p')
  if [ -z "$REGION" ]; then
    REGION=$(echo $BASENAME | sed -n -E 's,^([^/]+)\.zone$,\1,p')
  fi
  COMMUNITY="test.hex.camp"
  echo Community: $COMMUNITY
  echo Region: $REGION
  if [ -n "$REGION" ]; then
    DNS_UNPACKED=$(hexcamp-tool ehid-to-dns-unpacked $REGION)
  else
    DNS_UNPACKED=""
  fi
  echo DNS Unpacked: $DNS_UNPACKED
  cat << EOT > tmp/jq-cmd.txt
  {
    community: "$COMMUNITY",
    dnsUnpacked: "$DNS_UNPACKED",
    sites: \$sites[0],
    ips: \$ips[0],
    serial: "$SERIAL"
  }
EOT
  cat tmp/sites-jim.json | jq "[.[] | select(.region == \"$REGION\")]" > tmp/region-sites.json
  jq -n \
    --slurpfile sites tmp/region-sites.json \
    --slurpfile ips ips.json \
    -f tmp/jq-cmd.txt > tmp/data.json
  echo ">>" minijinja-cli templates/$DIRNAME/$BASENAME
  echo "Data:"
  cat tmp/data.json
  echo "---"
  minijinja-cli templates/$DIRNAME/$BASENAME tmp/data.json > current/$DIRNAME/$BASENAME
  if [ -f previous/$DIRNAME/$BASENAME -a -f current/$DIRNAME/$BASENAME ]; then
    PREVSUM=$(cat previous/$DIRNAME/$BASENAME | sha512sum)
    CURSUM=$(cat current/$DIRNAME/$BASENAME | sha512sum)
  else
    PREVSUM=0
    CURRSUM=1
  fi
  if [ "$PREVSUM" != "$CURSUM" ]; then
    DATE=$(date +"%Y%m%d")
    if (echo $SERIAL | grep "^$DATE") > /dev/null; then
      #echo Same Date, increment
      SERIAL=$((SERIAL + 1))
    else
      #echo New Date
      SERIAL="${DATE}01"
    fi
    #echo SERIAL: $SERIAL
    cat << EOT > tmp/jq-cmd.txt
    {
      community: "$COMMUNITY",
      dnsUnpacked: "$DNS_UNPACKED",
      sites: \$sites[0],
      ips: \$ips[0],
      serial: "$SERIAL"
    }
EOT
  jq -n \
    --slurpfile sites tmp/region-sites.json \
    --slurpfile ips ips.json \
    -f tmp/jq-cmd.txt > tmp/data.json
    echo "Data (bump serial):"
    cat tmp/data.json
    echo "---"
    minijinja-cli templates/$DIRNAME/$BASENAME tmp/data.json  > current/$DIRNAME/$BASENAME
  fi
}

mkdir -p tmp

csvclean -n sites/jim.csv > tmp/csv-clean.txt
if [ -n "$(cat tmp/csv-clean.txt | grep -v 'No errors.')" ]; then
  echo "CSV errors in sites/jim.csv!"
  cat tmp/csv-clean.txt
  exit 1
fi
csvjson sites/jim.csv > tmp/sites-jim.json

# OS X
#cat sites/jim.csv | csvclean -a > tmp/csv-clean.csv
#csvjson tmp/csv-clean.csv > tmp/sites-jim.json

#TEST=zones/gkgv6/h3/20/3/2/5/db.5.2.3.20.h3.seahex.org
TEST=
if [ -n "$TEST" ]; then
  echo $TEST
  gen_new_file $TEST
  diff -u previous/$TEST current/$TEST || true
  exit
fi

for f in $(find templates -type f -or -type l \! -name '*.swp' | sed 's,templates/,,' | grep -v 'corefiles/db\.'); do
  #echo $f
  gen_new_file $f
  diff -u previous/$f current/$f || true
done

