#! /bin/bash

#curl http://hexcamp-coredns-demo-doh2.default.cluster-5.localnet.farm:30080/dns-query?dns=H38BAAABAAAAAAAAATMBNAE1ATQBMgE0ATIBMQEyATQCNDYCaDMEdGVzdANoZXgEY2FtcAAAAQAB | xxd

#curl https://test-doh2.infra.hex.camp:30443/dns-query?dns=H38BAAABAAAAAAAAATMBNAE1ATQBMgE0ATIBMQEyATQCNDYCaDMEdGVzdANoZXgEY2FtcAAAAQAB | xxd

q @https://test-doh2.infra.hex.camp:30443 A 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp

