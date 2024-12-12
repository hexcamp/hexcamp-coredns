#! /bin/bash

#set -euxo pipefail
set -euo pipefail

gen_new_file() {
  DIRNAME=$(dirname $1)
  BASENAME=$(basename $1)
  mkdir -p current/$DIRNAME
  SERIAL=$(cat previous/$DIRNAME/$BASENAME | sed -n 's,; serial,,p')
  if [ -z "$SERIAL" ]; then
    cp templates/$DIRNAME/$BASENAME current/$DIRNAME/$BASENAME
    return
  fi
  cat ips.json | jq ".serial=$SERIAL" | minijinja-cli -f json templates/$DIRNAME/$BASENAME - > current/$DIRNAME/$BASENAME
  PREVSUM=$(cat previous/$DIRNAME/$BASENAME | sha512sum)
  CURSUM=$(cat current/$DIRNAME/$BASENAME | sha512sum)
  if [ "$PREVSUM" != "$CURSUM" ]; then
    DATE=$(date +"%Y%m%d")
    if (echo $SERIAL | grep "^$DATE"); then
      #echo Same Date, increment
      SERIAL=$((SERIAL + 1))
    else
      #echo New Date
      SERIAL="${DATE}01"
    fi
    echo SERIAL: $SERIAL
    cat ips.json | jq ".serial=$SERIAL" | minijinja-cli -f json templates/$DIRNAME/$BASENAME - > current/$DIRNAME/$BASENAME
  fi
}

for f in $(find templates -type f | sed 's,templates/,,'); do
  #echo $f
  gen_new_file $f
  diff -u previous/$f current/$f || true
done

