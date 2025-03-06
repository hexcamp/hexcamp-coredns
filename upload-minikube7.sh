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

rsync -qaP \
  --exclude '*.template' \
  --exclude .gitignore \
  . minikube7:/home/ubuntu/storage/coredns-test

cd ../../zones

rsync -qaP \
  ai \
  as7q \
  minikube7:/home/ubuntu/storage/coredns-data


