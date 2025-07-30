#! /bin/bash

MINIKUBE9=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube9; tofu output -raw public_ip)
echo minikube9: $MINIKUBE9
MINIKUBE10=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube10; tofu output -raw public_ip)
echo minikube10: $MINIKUBE10
MINIKUBE11=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube11; tofu output -raw public_ip)
echo minikube11: $MINIKUBE11

jq -n " \
  .minikube9_ip=\"$MINIKUBE9\" | \
  .minikube10_ip=\"$MINIKUBE10\" | \
  .minikube11_ip=\"$MINIKUBE11\"" > ips.json
cat ips.json | jq

