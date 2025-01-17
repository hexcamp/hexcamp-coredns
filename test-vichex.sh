#! /bin/bash

# Mt Tolmie
#
# https://2kgrvkwfni7q.test.hex.camp/

set -x

q @minikube9.localnet.farm A 2kgrvkwfni7q.test.hex.camp
# 2kgrvkwfni7q.test.hex.camp. 5s CNAME 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.test.hex.camp.

q @minikube9.localnet.farm A 2kgrvkwfni7q.vichex.ca
# 2kgrvkwfni7q.vichex.ca. 5s CNAME 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.vichex.ca.

q @minikube10.localnet.farm A 2kgrvkwfni7q.test.hex.camp
# 2kgrvkwfni7q.test.hex.camp. 5s CNAME 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.test.hex.camp.

q @minikube10.localnet.farm A 2kgrvkwfni7q.vichex.ca
# 2kgrvkwfni7q.vichex.ca. 5s CNAME 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.vichex.ca.

q @minikube8.localnet.farm A 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.test.hex.camp
# 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.test.hex.camp. 5m A 15.235.47.12

q @minikube8.localnet.farm A 0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.vichex.ca
#0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.vichex.ca. 5m A 15.235.47.12

q @minikube8.localnet.farm TXT _dnslink.0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.test.hex.camp
#_dnslink.0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.test.hex.camp. 32s TXT "dnslink=/ipfs/QmTo1A3fJ9ZsavLp4qhGiQrPz9fxyoD67gAkJntYSm8rZe"

q @minikube8.localnet.farm TXT _dnslink.0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.vichex.ca
#_dnslink.0.5.6.2.1.6.2.5.2.5.1.2.3.20.h3.vichex.ca. 1m TXT "dnslink=/ipfs/QmTo1A3fJ9ZsavLp4qhGiQrPz9fxyoD67gAkJntYSm8rZe"

q @8.8.8.8 2kgrvkwfni7q.vichex.ca
