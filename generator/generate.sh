#! /bin/bash

set -euxo pipefail

gen_new_file() {
  mkdir -p current/corefiles/minikube6
  SERIAL=$(cat previous/corefiles/minikube6/db.test.hex.camp | sed -n 's,; serial,,p')
  cat ips.json | jq ".serial=$SERIAL" | minijinja-cli -f json templates/corefiles/minikube6/db.test.hex.camp - > current/corefiles/minikube6/db.test.hex.camp
  PREVSUM=$(cat previous/corefiles/minikube6/db.test.hex.camp | sha512sum)
  CURSUM=$(cat current/corefiles/minikube6/db.test.hex.camp | sha512sum)
  if [ "$PREVSUM" != "$CURSUM" ]; then
    DATE=$(date +"%Y%m%d")
    if (echo $SERIAL | grep "^$DATE"); then
      echo Same Date, increment
      SERIAL=$((SERIAL + 1))
    else
      echo New Date
      SERIAL="${DATE}01"
    fi
    echo SERIAL: $SERIAL
    cat ips.json | jq ".serial=$SERIAL" | minijinja-cli -f json templates/corefiles/minikube6/db.test.hex.camp - > current/corefiles/minikube6/db.test.hex.camp
  PREVSUM=$(cat previous/corefiles/minikube6/db.test.hex.camp | sha512sum)
  fi
}

gen_new_file corefiles/minikube6/db.test.hex.camp

