#! /bin/bash

set -e

if [ -z "$JIMPICK_DNS_READONLY_ACCESS_KEY_ID" ]; then
  echo Need JIMPICK_DNS_READONLY_ACCESS_KEY_ID
fi
if [ -z "$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY" ]; then
  echo Need JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY
fi

TOP=$(pwd)

MINIKUBE=minikube11

cd generator/current/corefiles/$MINIKUBE

cat Corefile.template | \
  sed "s,<key>,\"$JIMPICK_DNS_READONLY_ACCESS_KEY_ID\"," | \
  sed "s,<secret>,\"$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY\","  \
  > Corefile

echo $MINIKUBE: proxy
$TOP/rclone-sync.sh $MINIKUBE proxy .

cd ../../zones

for z in \
	ai \
	as7q \
	akpq \
	axpq \
	ikgrw \
	gkgy6 \
	gkgv6 \
	; do \
		echo $MINIKUBE: $z; \
		$TOP/rclone-sync.sh $MINIKUBE $z $z
	done

cd ../bundles

for b in \
	vanhex \
	islandhex \
  peerhex-americas \
	; do \
		echo $MINIKUBE: $b; \
		$TOP/rclone-sync.sh $MINIKUBE $b $b/zones
	done


