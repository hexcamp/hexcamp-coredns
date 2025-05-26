#! /bin/sh

set -eu

cd /data/hexcamp-coredns

echo "Updating zones..."

echo "git pull:"
git stash
git pull
git stash apply || true

echo "Last IPs:"
cat generator/ips.json

if [ ! -f /tmp/cloudevent.json ]; then
  echo Missing /tmp/cloudevent.json
  exit 1
fi

cat /tmp/cloudevent.json | jq > generator/ips.json
echo "New IPs from CloudEvent:"
cat generator/ips.json

IP_7=$(cat generator/ips.json | jq -r .minikube7_ip)
IP_8=$(cat generator/ips.json | jq -r .minikube8_ip)
IP_9=$(cat generator/ips.json | jq -r .minikube9_ip)
IP_10=$(cat generator/ips.json | jq -r .minikube10_ip)

set +e
if [ -n "$IP_7" ]; then
  echo "minikube7: http://$IP_7:9153/metrics"
  echo -n "           "
  timeout 5 curl -s http://$IP_7:9153/metrics | grep ^coredns_build_info
  echo
fi
if [ -n "$IP_8" ]; then
  echo "minikube8: http://$IP_8:9153/metrics"
  echo -n "           "
  timeout 5 curl -s http://$IP_8:9153/metrics | grep ^coredns_build_info
  echo
fi
if [ -n "$IP_9" ]; then
  echo "minikube9: http://$IP_9:9153/metrics"
  echo -n "           "
  timeout 5 curl -s http://$IP_9:9153/metrics | grep ^coredns_build_info
  echo
fi
if [ -n "$IP_10" ]; then
  echo "minikube10: http://$IP_10:9153/metrics"
  echo -n "            "
  timeout 5 curl -s http://$IP_10:9153/metrics | grep ^coredns_build_info
  echo
fi
set -e
echo

echo Copying site data
cp -v /sites/jim.csv generator/sites/jim.csv

cd generator
./copy-current-to-prev.sh
./generate.sh
cd ..

set +e
if [ -n "$IP_7" ]; then
  echo Uploading to minikube7
  timeout -v 30 ./upload-minikube7-zone-generator.sh
fi
if [ -n "$IP_8" ]; then
  echo Uploading to minikube8
  timeout -v 30 ./upload-minikube8-zone-generator.sh
fi
if [ -n "$IP_9" ]; then
  echo Uploading to minikube9
  timeout -v 30 ./upload-minikube9-zone-generator.sh
fi
if [ -n "$IP_10" ]; then
  echo Uploading to minikube10
  timeout -v 30 ./upload-minikube10-zone-generator.sh
fi

echo "Done."
