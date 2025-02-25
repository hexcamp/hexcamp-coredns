#! /bin/bash

set -euxo pipefail

sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

ssh minikube7 date
ssh minikube8 date
ssh minikube9 date
ssh minikube10 date

pushd generator
./copy-current-to-prev.sh
./update-ips-from-tofu.sh
./generate.sh
popd

set +e
./upload-minikube7.sh
./upload-minikube8.sh
./upload-minikube9.sh
./upload-minikube10.sh
