#! /bin/bash

#q @jpimac.local:1053 A uxirkffr.hex.camp


#echo Query uxirkffr.test.hex.camp from first DOH via proxy

#q @dns1000.localhost:53 A uxirkffr.test.hex.camp

#echo

#echo Query 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp from second DOH via proxy

#q @dns-doh2-localnet-farm-5:53 A 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp

#echo

#echo Query uxirkffr.test.hex.camp using live DNS via local unbound


echo uxirkffr.test.hex.camp
q @8.8.8.8 A uxirkffr.test.hex.camp
q @8.8.8.8 TXT _dnslink.uxirkffr.test.hex.camp
echo

echo 6l22glmvqj2a.test.hex.camp
q @8.8.8.8 A 6l22glmvqj2a.test.hex.camp
q @8.8.8.8 TXT _dnslink.6l22glmvqj2a.test.hex.camp
echo

echo 2kgrv5ga2i.test.hex.camp
q @8.8.8.8 A 2kgrv5ga2i.test.hex.camp
q @8.8.8.8 TXT _dnslink.2kgrv5ga2i.test.hex.camp
q @2600:1f11:2fc:e406:9c72:2191:70b0:5e83 A 3.1.5.1.0.6.4.6.3.5.1.2.3.20.h3.test.hex.camp
echo

# q @https://axpq.doh-test.hex.camp:30443 a 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp
#   3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h CNAME pq-pop-ca-1.infra.hex.camp.
# q @https://axpq.doh-test.hex.camp:30443 txt _dnslink.3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp
#   _dnslink.3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 30s TXT "dnslink=/ipfs/QmP8zX12WAbaaFyZGW9guhcTfVhyv1fiZjFYwJanoMeqAX"


# minikube6 / minikube9 - Hawaii

# curl 'https://axpq.doh-test.hex.camp:30443/dns-query?ct=application/dns-message&dns=AAABAAABAAAAAAAAAAACAAE' --output - | xxd 
#

# q @minikube6.localnet.farm A uxirkffr.test.hex.camp
# uxirkffr.test.hex.camp. 0s CNAME 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.

# q @minikube9.localnet.farm A 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.
# 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h CNAME pq-pop-ca-1.infra.hex.camp.

# minikube6 / minikube7 - Tokyo, Okinawa

# 6l22glmvqj2a.test.hex.camp - Encoded Hexagon lookup tool

# q @minikube6.localnet.farm A 6l22glmvqj2a.test.hex.camp
# 6l22glmvqj2a.test.hex.camp. 0s CNAME 4.6.1.1.0.3.5.4.5.5.4.1.2.3.5.23.h3.test.hex.camp.

# q @minikube7.localnet.farm A 4.6.1.1.0.3.5.4.5.5.4.1.2.3.5.23.h3.test.hex.camp.
# 4.6.1.1.0.3.5.4.5.5.4.1.2.3.5.23.h3.test.hex.camp. 1h CNAME pq-pop-ca-1.infra.hex.camp.

# q @8.8.8.8 A 6l22glmvqj2a.test.hex.camp
# pq-pop-ca-1.infra.hex.camp. 5m A 15.235.47.12
# 6l22glmvqj2a.test.hex.camp. 0s CNAME 4.6.1.1.0.3.5.4.5.5.4.1.2.3.5.23.h3.test.hex.camp.
# 4.6.1.1.0.3.5.4.5.5.4.1.2.3.5.23.h3.test.hex.camp. 1h CNAME pq-pop-ca-1.infra.hex.camp.

# q @8.8.8.8 TXT _dnslink.6l22glmvqj2a.test.hex.camp

# Okinawa photos

# q @minikube6.localnet.farm A ssrgdfv3.test.hex.camp
# ssrgdfv3.test.hex.camp. 0s CNAME 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp.

# q @minikube7.localnet.farm A 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp.
# 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp. 5m A 15.235.47.12

# q @8.8.8.8 A ssrgdfv3.test.hex.camp
# pq-pop-ca-1.infra.hex.camp. 5m A 15.235.47.12
# ssrgdfv3.test.hex.camp. 0s CNAME 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp.
# 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp. 5s CNAME pq-pop-ca-1.infra.hex.camp.

# q @https://as7q.doh-test.hex.camp:30443 A 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp
# 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp. 5m A 15.235.47.12

# DOH-HTTPS
# q @https://as7q.doh-test.hex.camp:30443 A 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp

# DOH-HTTP
# q @http://as7q.doh-test.hex.camp:30080 A 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp

# Local test coredns - UDP
# q @127.0.0.1:5300 A 6.5.6.2.6.0.6.4.0.37.h3.test.hex.camp

# curl 'https://as7q.doh-test.hex.camp:30443/dns-query?ct=application/dns-message&dns=AAABAAABAAAAAAAAAAACAAE' --output - | xxd 
#
