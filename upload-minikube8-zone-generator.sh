#! /bin/bash

set -e

if [ -z "$JIMPICK_DNS_READONLY_ACCESS_KEY_ID" ]; then
  echo Need JIMPICK_DNS_READONLY_ACCESS_KEY_ID
fi
if [ -z "$JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY" ]; then
  echo Need JIMPICK_DNS_READONLY_SECRET_ACCESS_KEY
fi

TOP=$(pwd)

cd generator/current/corefiles/minikube8

#rclone sync --ignore-times . minikube8-proxy:
$TOP/rclone-sync.sh minikube8 proxy .

cd ../../zones

for z in \
	ai \
	as7q \
	akpq \
	ikgrw \
	gkgy6 \
	gkgv6 \
	; do \
		echo minikube8: $z; \
		$TOP/rclone-sync.sh minikube8 $z $z
	done

#rclone sync --ignore-times ai minikube8-ai:
#rclone sync --ignore-times as7q minikube8-as7q:
#rclone sync --ignore-times akpq minikube8-akpq:
#rclone sync --ignore-times ikgrw minikube8-ikgrw:
#rclone sync --ignore-times gkgy6 minikube8-gkgy6:
#rclone sync --ignore-times gkgv6 minikube8-gkgv6:
