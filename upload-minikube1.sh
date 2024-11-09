#! /bin/bash

. SETENV

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo Need AWS_ACCESS_KEY_ID in SETENV
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo Need AWS_SECRET_ACCESS_KEY in SETENV
fi

cd top-level-corefiles/minikube1

cat Corefile.template | \
  sed "s,<key>,\"$AWS_ACCESS_KEY_ID\"," | \
  sed "s,<secret>,\"$AWS_SECRET_ACCESS_KEY\","  \
  > Corefile

rsync -vaP \
  --exclude '*.template' \
  --exclude .gitignore \
  . minikube1:/home/centos/storage/coredns-test


