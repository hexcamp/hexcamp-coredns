#! /bin/sh

set -eu

cd /data/hexcamp-coredns

trap "" SIGINT

./update-zones2.sh 2>&1

