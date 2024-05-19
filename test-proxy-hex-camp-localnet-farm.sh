#! /bin/bash

#q @jpimac.local:1053 A uxirkffr.hex.camp


echo Query uxirkffr.test.hex.camp from first DOH via proxy

q @dns1000.localhost:53 A uxirkffr.test.hex.camp

echo

echo Query 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp from second DOH via proxy

q @dns-doh2-localnet-farm-5:53 A 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp

echo

echo Query uxirkffr.test.hex.camp using live DNS via local unbound

q @127.0.0.1:2053 A uxirkffr.test.hex.camp


