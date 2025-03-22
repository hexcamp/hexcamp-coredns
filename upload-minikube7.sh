#! /bin/bash

set -e

. SETENV

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo Need AWS_ACCESS_KEY_ID in SETENV
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo Need AWS_SECRET_ACCESS_KEY in SETENV
fi

cd generator/current/corefiles/minikube7

rclone sync --ignore-times . minikube7-proxy:

cd ../../zones

rclone sync --ignore-times ai minikube7-ai:
rclone sync --ignore-times as7q minikube7-as7q:
rclone sync --ignore-times akpq minikube7-akpq:
rclone sync --ignore-times ikgrw minikube7-ikgrw:
rclone sync --ignore-times gkgy6 minikube7-gkgy6:
rclone sync --ignore-times gkgv6 minikube7-gkgv6:

