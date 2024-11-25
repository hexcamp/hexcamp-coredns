#! /bin/bash


REGION=$!

if [ -z "$REGION" ]; then
  REGION=as7q
fi

while true; do echo -n .; kubectl -n $REGION logs -f `kubectl -n $REGION get pods -o json | jq -r '.items[0].metadata.name'` 2> /dev/null; sleep 1; done
