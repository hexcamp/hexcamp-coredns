#! /bin/bash

set -euo pipefail

echo "Events:"
kubectl --context ryzen9 -n repair logs -l app=event-display | tail -7

echo "Last IPs:"
cat generator/ips.json

echo "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
#sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

cd generator
./update-ips-from-tofu.sh
cd ..

#IP_7=$(cat generator/ips.json | jq -r .minikube7_ip)
#IP_8=$(cat generator/ips.json | jq -r .minikube8_ip)
IP_9=$(cat generator/ips.json | jq -r .minikube9_ip)
IP_10=$(cat generator/ips.json | jq -r .minikube10_ip)
IP_11=$(cat generator/ips.json | jq -r .minikube11_ip)

set +e
#if [ -n "$IP_7" ]; then
#  echo "minikube7: http://$IP_7:9153/metrics"
#  echo -n "           "
#  timeout -v 5 curl -s http://$IP_7:9153/metrics | grep ^coredns_build_info
#  echo
#fi
#if [ -n "$IP_8" ]; then
#  echo "minikube8: http://$IP_8:9153/metrics"
#  echo -n "           "
#  timeout -v 5 curl -s http://$IP_8:9153/metrics | grep ^coredns_build_info
#  echo
#fi
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
if [ -n "$IP_11" ]; then
  echo "minikube11: http://$IP_11:9153/metrics"
  echo -n "            "
  timeout -v 5 curl -s http://$IP_11:9153/metrics | grep ^coredns_build_info
  echo
fi
set -e
echo

cd generator
./copy-current-to-prev.sh
./generate.sh

exit


#cd ..
#set +e
#if [ -n "$IP_7" ]; then
#  echo Uploading to minikube7
#  timeout -v 30 ./upload-minikube7.sh
#fi
#if [ -n "$IP_8" ]; then
#  echo Uploading to minikube8
#  timeout -v 30 ./upload-minikube8.sh
#fi
#if [ -n "$IP_9" ]; then
#  echo Uploading to minikube9
#  timeout -v 30 ./upload-minikube9.sh
#fi
#if [ -n "$IP_10" ]; then
#  echo Uploading to minikube10
#  timeout -v 30 ./upload-minikube10.sh
#fi
#echo Updating nonce for seahex.org
#./update-nonce-seahex.sh
#echo Updating nonce for vichex.ca
#./update-nonce-vichex.sh


echo Done.
