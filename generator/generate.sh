#! /bin/bash

# Uses: csvkit
# brew install csvkit
# https://csvkit.readthedocs.io/en/latest/

#set -euxo pipefail
set -euo pipefail

gen_new_file() {
  DIRNAME=$(dirname $1)
  BASENAME=$(basename $1)
  mkdir -p current/$DIRNAME
  SERIAL=$(cat previous/$DIRNAME/$BASENAME | sed -n -E 's,^[[:space:]]+([[:digit:]]+).*; serial,\1,p')
  if [ -z "$SERIAL" ]; then
    cp templates/$DIRNAME/$BASENAME current/$DIRNAME/$BASENAME
    return
  fi
  cat << EOT > tmp/jq-cmd.txt
  {
    sites: \$sites[0],
    ips: \$ips[0],
    serial: "$SERIAL"
  }
EOT
  REGION=$(echo $DIRNAME | sed -n -E 's,^.*zones/([^/]+)/.*,\1,p')
  cat tmp/sites-jim.json | jq "[.[] | select(.region == \"$REGION\")]" > tmp/region-sites.json
  jq -n \
    --slurpfile sites tmp/region-sites.json \
    --slurpfile ips ips.json \
    -f tmp/jq-cmd.txt > tmp/data.json
  minijinja-cli templates/$DIRNAME/$BASENAME tmp/data.json > current/$DIRNAME/$BASENAME
  PREVSUM=$(cat previous/$DIRNAME/$BASENAME | sha512sum)
  CURSUM=$(cat current/$DIRNAME/$BASENAME | sha512sum)
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
      sites: \$sites[0],
      ips: \$ips[0],
      serial: "$SERIAL"
    }
EOT
  jq -n \
    --slurpfile sites tmp/region-sites.json \
    --slurpfile ips ips.json \
    -f tmp/jq-cmd.txt > tmp/data.json
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

for f in $(find templates -type f | sed 's,templates/,,'); do
  #echo $f
  gen_new_file $f
  diff -u previous/$f current/$f || true
done

