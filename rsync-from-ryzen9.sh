#! /bin/bash

DIR=/var/lib/rancher/k3s/storage/pvc-fe5e2630-8988-417f-a006-ccf61e2a902b_repair_repair-hexcamp-coredns/hexcamp-coredns/generator/

rsync -vaP root@ryzen9:$DIR/current/ generator/current
rsync -vaP root@ryzen9:$DIR/previous/ generator/previous
rsync -vaP root@ryzen9:$DIR/ips.json generator/ips.json
