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


