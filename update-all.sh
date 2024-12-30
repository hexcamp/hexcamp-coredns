#! /bin/bash

set -euxo pipefail

pushd generator
./copy-current-to-prev.sh
./update-ips-from-tofu.sh
./generate.sh
popd

./upload-minikube6.sh
./upload-minikube7.sh
./upload-minikube8.sh
./upload-minikube9.sh
