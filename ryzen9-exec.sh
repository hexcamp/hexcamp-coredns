#! /bin/bash

NAME=$(kubectl --context ryzen9 -n repair get pods -l serving.knative.dev/service=zone-generator -o name)

kubectl --context ryzen9 -n repair exec -it $NAME -- bash

