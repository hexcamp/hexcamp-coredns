#! /bin/bash

set -x

q @minikube9.localnet.farm A 6kg6rqaaaaaa.vanhex.ca
#0.0.0.0.0.0.0.0.0.0.3.4.6.3.3.20.h3.vanhex.ca. 5m A 144.217.233.191
#6kg6rqaaaaaa.vanhex.ca. 596523h14m7s CNAME 0.0.0.0.0.0.0.0.0.0.3.4.6.3.3.20.h3.vanhex.ca.

# Base cell 20

$ q @http://hexcamp-akpq.akpq.minikube7.localnet.farm:30080 NS 20.h3.vanhex.ca.
20.h3.vanhex.ca. 5m NS ns-minikube7.20.h3.vanhex.ca.
20.h3.vanhex.ca. 5m NS ns-minikube8.20.h3.vanhex.ca.

