#! /bin/bash

set -e

. SETENV

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo Need AWS_ACCESS_KEY_ID in SETENV
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo Need AWS_SECRET_ACCESS_KEY in SETENV
fi

cd generator/current/corefiles/minikube9

cat Corefile.template | \
  sed "s,<key>,\"$AWS_ACCESS_KEY_ID\"," | \
  sed "s,<secret>,\"$AWS_SECRET_ACCESS_KEY\","  \
  > Corefile

rclone sync --ignore-times . minikube9-proxy:

cd ../../zones

rclone sync --ignore-times axpq minikube9-axpq:

