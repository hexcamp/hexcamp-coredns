#! /bin/bash

set -euo pipefail

echo "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

cd generator
./update-ips-from-tofu.sh
cd ..

IP_7=$(cat generator/ips.json | jq -r .minikube7_ip)
IP_8=$(cat generator/ips.json | jq -r .minikube8_ip)
IP_9=$(cat generator/ips.json | jq -r .minikube9_ip)
IP_10=$(cat generator/ips.json | jq -r .minikube10_ip)

if [ -n "$IP_7" ]; then
  echo -n "minikube7: "
  ssh minikube7 date
fi
if [ -n "$IP_8" ]; then
  echo -n "minikube8: "
  ssh minikube8 date
fi
if [ -n "$IP_9" ]; then
  echo -n "minikube9: "
  ssh minikube9 date
fi
if [ -n "$IP_10" ]; then
  echo -n "minikube10: "
  ssh minikube10 date
fi

cd generator
./copy-current-to-prev.sh
./generate.sh
cd ..

set +e
if [ -n "$IP_7" ]; then
  echo Uploading to minikube7
  ./upload-minikube7.sh
fi
if [ -n "$IP_8" ]; then
  echo Uploading to minikube8
  ./upload-minikube8.sh
fi
if [ -n "$IP_9" ]; then
  echo Uploading to minikube9
  ./upload-minikube9.sh
fi
if [ -n "$IP_10" ]; then
  echo Uploading to minikube10
  ./upload-minikube10.sh
fi

echo Done.
