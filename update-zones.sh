#! /bin/sh

set -eu

cd /data/hexcamp-coredns

echo "Jim fake error 2" 1>&2
exit 1

./update-zones2.sh 2>&1

