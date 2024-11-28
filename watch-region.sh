#! /bin/bash

CONTEXT=minikube5
REGION=$1


if [ -z "$REGION" ]; then
  REGION=as7q
fi

while true; do echo -n .; kubectl --context $CONTEXT -n $REGION logs -f `kubectl --context $CONTEXT -n $REGION get pods -o json | jq -r '.items[0].metadata.name'` 2> /dev/null; sleep 1; done
