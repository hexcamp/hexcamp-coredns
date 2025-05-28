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

DIR=${3-}

if [ -z "$DIR" ]; then
	echo Need DIR
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
  contimeout=10s \
  timeout=15s \
	--non-interactive > /dev/null

#rclone sync -v --ignore-times $DIR $CLUSTER-proxy: 
rclone sync --ignore-times $DIR $CLUSTER-$ZONE: 


