while true; do kubectl --context minikube10 logs -f coredns-proxy; sleep 1; done
