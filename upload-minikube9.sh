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

rsync -qaP \
  --exclude '*.template' \
  --exclude .gitignore \
  . minikube9:/home/ubuntu/storage/coredns-test

cd ../../zones

rsync -qaP \
  axpq \
  minikube9:/home/ubuntu/storage/coredns-data


