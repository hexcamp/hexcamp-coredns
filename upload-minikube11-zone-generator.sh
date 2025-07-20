#! /bin/bash

set -e

if [ -z "$JIMPICK_DNS_READONLY_ACCESS_KEY_ID" ]; then
  echo Need JIMPICK_DNS_READONLY_ACCESS_KEY_ID
fi
if [ -z "$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY" ]; then
  echo Need JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY
fi

TOP=$(pwd)

cd generator/current/corefiles/minikube11

cat Corefile.template | \
  sed "s,<key>,\"$JIMPICK_DNS_READONLY_ACCESS_KEY_ID\"," | \
  sed "s,<secret>,\"$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY\","  \
  > Corefile

echo minikube11: proxy
$TOP/rclone-sync.sh minikube11 proxy .

cd ../../zones

for z in \
	ai \
	as7q \
	akpq \
	ikgrw \
	gkgy6 \
	gkgv6 \
	; do \
		echo minikube11: $z; \
		$TOP/rclone-sync.sh minikube11 $z $z
	done

cd ../bundles

for b in \
	vanhex \
	; do \
		echo minikube11: $b; \
		$TOP/rclone-sync.sh minikube11 $b $b/zones
	done


