#! /bin/sh

set -eu

cd /data/hexcamp-coredns

echo "Updating zones..."

echo "git pull:"
git stash
git pull
git stash apply || true

#echo "Jim fake error"
#echo fake error 1>&2
#exit 1

echo "Last IPs:"
cat generator/ips.json

if [ ! -f /ips/ips.json ]; then
  echo Missing /ips/ips.json
  exit 1
fi

cat /ips/ips.json | jq > generator/ips.json
echo "New IPs from /ips:"
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
mkdir -p /root/.config/rclone
touch /root/.config/rclone/rclone.conf

if [ -n "$IP_7" ]; then
  echo Uploading to minikube7
  /usr/bin/timeout -v 30 ./upload-minikube7-zone-generator.sh 2>&1
fi
if [ -n "$IP_8" ]; then
  echo Uploading to minikube8
  /usr/bin/timeout -v 30 ./upload-minikube8-zone-generator.sh 2>&1
fi
if [ -n "$IP_9" ]; then
  echo Uploading to minikube9
  /usr/bin/timeout -v 30 ./upload-minikube9-zone-generator.sh 2>&1
fi
if [ -n "$IP_10" ]; then
  echo Uploading to minikube10
  /usr/bin/timeout -v 30 ./upload-minikube10-zone-generator.sh 2>&1
fi

echo "Done."
