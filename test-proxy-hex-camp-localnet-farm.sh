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
#dig 6l22glmvqj2a.test.hex.camp
