#! /bin/bash

set -euo pipefail

echo "Events:"
kubectl --context ryzen9 -n repair logs -l app=event-display | tail -7

echo "Last IPs:"
cat generator/ips.json

echo "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

cd generator
./update-ips-from-tofu.sh
cd ..

IP_7=$(cat generator/ips.json | jq -r .minikube7_ip)
IP_8=$(cat generator/ips.json | jq -r .minikube8_ip)
IP_9=$(cat generator/ips.json | jq -r .minikube9_ip)
IP_10=$(cat generator/ips.json | jq -r .minikube10_ip)

set +e
if [ -n "$IP_7" ]; then
  echo "minikube7: http://$IP_7:9153/metrics"
  echo -n "           "
  timeout -v 5 curl -s http://$IP_7:9153/metrics | grep ^coredns_build_info
  echo
fi
if [ -n "$IP_8" ]; then
  echo "minikube8: http://$IP_8:9153/metrics"
  echo -n "           "
  timeout -v 5 curl -s http://$IP_8:9153/metrics | grep ^coredns_build_info
  echo
fi
if [ -n "$IP_9" ]; then
  echo "minikube9: http://$IP_9:9153/metrics"
  echo -n "           "
  timeout -v 5 curl -s http://$IP_9:9153/metrics | grep ^coredns_build_info
  echo
fi
if [ -n "$IP_10" ]; then
  echo "minikube10: http://$IP_10:9153/metrics"
  echo -n "            "
  timeout -v 5 curl -s http://$IP_10:9153/metrics | grep ^coredns_build_info
  echo
fi
set -e
echo

cd generator
./copy-current-to-prev.sh
./generate.sh
cd ..

set +e
if [ -n "$IP_7" ]; then
  echo Uploading to minikube7
  timeout -v 15 ./upload-minikube7.sh
fi
if [ -n "$IP_8" ]; then
  echo Uploading to minikube8
  timeout -v 15 ./upload-minikube8.sh
fi
if [ -n "$IP_9" ]; then
  echo Uploading to minikube9
  timeout -v 15 ./upload-minikube9.sh
fi
if [ -n "$IP_10" ]; then
  echo Uploading to minikube10
  timeout -v 15 ./upload-minikube10.sh
fi

echo Done.
