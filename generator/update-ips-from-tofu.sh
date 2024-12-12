#! /bin/bash

MINIKUBE6=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube6; tofu output -raw public_ip)
echo minikube6: $MINIKUBE6
MINIKUBE7=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube7; tofu output -raw public_ip)
echo minikube7: $MINIKUBE7
MINIKUBE8=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube8; tofu output -raw public_ip)
echo minikube8: $MINIKUBE8
MINIKUBE9=$(cd ~/hexcamp-jpimac/localnet-farm/hexcamp-terraform-aws-minikube/examples/minikube9; tofu output -raw public_ip)
echo minikube9: $MINIKUBE9

jq -n " \
  .minikube6_ip=\"$MINIKUBE6\" | \
  .minikube7_ip=\"$MINIKUBE7\" | \
  .minikube8_ip=\"$MINIKUBE8\" | \
  .minikube9_ip=\"$MINIKUBE9\"" > ips.json
cat ips.json | jq

