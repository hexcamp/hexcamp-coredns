#! /bin/bash

. SETENV

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo Need AWS_ACCESS_KEY_ID in SETENV
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo Need AWS_SECRET_ACCESS_KEY in SETENV
fi

cd top-level-corefiles/minikube3

rsync -vaP \
  --exclude '*.template' \
  --exclude .gitignore \
  . minikube3:/home/centos/storage/coredns-test

cd ../../coredns-data

rsync -vaP \
  ai \
  as7q \
  minikube3:/home/centos/storage/coredns-data


