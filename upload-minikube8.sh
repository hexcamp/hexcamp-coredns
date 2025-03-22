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

rclone sync --ignore-times . minikube8-proxy:

cd ../../zones

rclone sync --ignore-times ai minikube8-ai:
rclone sync --ignore-times as7q minikube8-as7q:
rclone sync --ignore-times akpq minikube8-akpq:
rclone sync --ignore-times ikgrw minikube8-ikgrw:
rclone sync --ignore-times gkgy6 minikube8-gkgy6:
rclone sync --ignore-times gkgv6 minikube8-gkgv6:
