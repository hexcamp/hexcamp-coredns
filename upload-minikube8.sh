#! /bin/bash

set -e

. SETENV

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo Need AWS_ACCESS_KEY_ID in SETENV
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo Need AWS_SECRET_ACCESS_KEY in SETENV
fi

cd generator/current/corefiles/minikube8

rclone copy . minikube8-proxy:

cd ../../zones

rclone copy akpq minikube8-akpq:
rclone copy ikgrw minikube8-ikgrw:
rclone copy gkgy6 minikube8-gkgy6:

