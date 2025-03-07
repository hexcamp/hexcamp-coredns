#! /bin/bash

set -euo pipefail

set -x
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
set +x

pushd generator
./update-ips-from-tofu.sh
popd

IP_7=$(cat generator/ips.json | jq -r .minikube7_ip)
IP_8=$(cat generator/ips.json | jq -r .minikube8_ip)
IP_9=$(cat generator/ips.json | jq -r .minikube9_ip)
IP_10=$(cat generator/ips.json | jq -r .minikube10_ip)

set -x
if [ -n "$IP_7" ]; then
  ssh minikube7 date
fi
if [ -n "$IP_8" ]; then
  ssh minikube8 date
fi
if [ -n "$IP_9" ]; then
  ssh minikube9 date
fi
if [ -n "$IP_10" ]; then
  ssh minikube10 date
fi

pushd generator
./copy-current-to-prev.sh
./generate.sh
popd

set +e
if [ -n "$IP_7" ]; then
  ./upload-minikube7.sh
fi
if [ -n "$IP_8" ]; then
  ./upload-minikube8.sh
fi
if [ -n "$IP_9" ]; then
  ./upload-minikube9.sh
fi
if [ -n "$IP_10" ]; then
  ./upload-minikube10.sh
fi
