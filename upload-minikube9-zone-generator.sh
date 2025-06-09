#! /bin/bash

set -e

if [ -z "$JIMPICK_DNS_READONLY_ACCESS_KEY_ID" ]; then
  echo Need JIMPICK_DNS_READONLY_ACCESS_KEY_ID
fi
if [ -z "$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY" ]; then
  echo Need JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY
fi

TOP=$(pwd)

cd generator/current/corefiles/minikube9

cat Corefile.template | \
  sed "s,<key>,\"$JIMPICK_DNS_READONLY_ACCESS_KEY_ID\"," | \
  sed "s,<secret>,\"$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY\","  \
  > Corefile

#rclone sync --ignore-times . minikube9-proxy:
echo minikube9: proxy
$TOP/rclone-sync.sh minikube9 proxy .

cd ../../zones

#rclone sync --ignore-times axpq minikube9-axpq:

for z in \
	axpq \
	; do \
		echo minikube9: $z; \
		$TOP/rclone-sync.sh minikube9 $z $z
	done


