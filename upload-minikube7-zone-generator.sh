#! /bin/bash

set -e

if [ -z "$JIMPICK_DNS_READONLY_ACCESS_KEY_ID" ]; then
  echo Need JIMPICK_DNS_READONLY_ACCESS_KEY_ID
fi
if [ -z "$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY" ]; then
  echo Need JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY
fi

TOP=$(pwd)

cd generator/current/corefiles/minikube7

#rclone sync --ignore-times . minikube7-proxy:
$TOP/rclone-sync.sh minikube7 proxy .

cd ../../zones

for z in \
	ai \
	as7q \
	akpq \
	ikgrw \
	gkgy6 \
	gkgv6 \
	; do \
		echo minikube7: $z; \
		$TOP/rclone-sync.sh minikube7 $z $z
	done

cd ../bundles

for b in \
	vanhex \
	; do \
		echo minikube7: $b; \
		$TOP/rclone-sync.sh minikube7 $b $b
	done


#rclone sync --ignore-times ai minikube7-ai:
#rclone sync --ignore-times as7q minikube7-as7q:
#rclone sync --ignore-times akpq minikube7-akpq:
#rclone sync --ignore-times ikgrw minikube7-ikgrw:
#rclone sync --ignore-times gkgy6 minikube7-gkgy6:
#rclone sync --ignore-times gkgv6 minikube7-gkgv6:
