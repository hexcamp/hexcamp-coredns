#! /bin/bash

set -euo pipefail

CLUSTER=${1-}

if [ -z "$CLUSTER" ]; then
	echo Need CLUSTER
	exit 1
fi

ZONE=${2-}

if [ -z "$ZONE" ]; then
	echo Need ZONE
	exit 1
fi


if [ -z "$RCLONE_PASSWORD" ]; then
	echo Need RCLONE_PASSWORD
	exit 1
fi

rclone config create $CLUSTER-$ZONE webdav \
	url=https://rclone-$CLUSTER-$ZONE.infra.hex.camp:30443 \
	vendor=other \
	pass=$RCLONE_PASSWORD \
	user=admin \
	--non-interactive > /dev/null

#mkdir -p /root/.config/rclone
#
#if [ -f /root/.config/rclone/rclone.conf ]; then
#	echo rclone.conf already exists
#	exit 1
#fi
#
#trap "rm -f /root/.config/rclone/rclone.conf" EXIT
#
#cat <<EOF > /root/.config/rclone/rclone.conf
#[$CLUSTER-proxy]
#type = webdav
#url = https://rclone-$CLUSTER-proxy.infra.hex.camp:30443
#vendor = other
#pass = $RCLONE_PASSWORD
#user = admin
#EOF

rclone ls $CLUSTER-$ZONE: 


