hexcamp-coredns
===============

## jpimac

```
./run-doh.sh
./run-doh2.sh
./run-proxy.sh
./run-unbound.sh

$ ./test-proxy-hex-camp.sh
Query uxirkffr.test.hex.camp from first DOH via proxy
uxirkffr.test.hex.camp. 1h CNAME 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.

Query 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp from second DOH via proxy
3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h A 127.0.0.1

Query uxirkffr.test.hex.camp using live DNS via local unbound
3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h A 127.0.0.1
uxirkffr.test.hex.camp. 59m59s CNAME 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.
```

## localnet-farm-5

```
./run-doh.sh
./run-proxy2.sh
./run-unbound.sh

$ ./test-proxy-hex-camp.sh
Query uxirkffr.test.hex.camp from first DOH via proxy
uxirkffr.test.hex.camp. 1h CNAME 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.

Query 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp from second DOH via proxy
3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h A 127.0.0.1

Query uxirkffr.test.hex.camp using live DNS via local unbound
3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h A 127.0.0.1
uxirkffr.test.hex.camp. 59m59s CNAME 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.
```

## localnet-farm-5 using proxy for doh2

```
On the DNS server:

(in tmux) ./run-proxy-localnet-farm.sh

$ ./test-proxy-hex-camp-localnet-farm.sh
3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp. 1h A 127.0.0.1
uxirkffr.test.hex.camp. 1h CNAME 3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.

$ dig +nocmd @2600:1f11:2fc:e405:3d19:5862:7e21:2f5b cname uxirkffr.test.hex.camp +noall +additional
uxirkffr.test.hex.camp.	0	IN	CNAME	3.4.5.4.2.4.2.1.2.4.46.h3.test.hex.camp.
```

# License

MIT or Apache 2
