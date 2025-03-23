#! /bin/sh

set -euxo pipefail

export AWS_PROFILE=default

# vichex.ca
HOSTED_ZONE_ID=Z07768951ZVF1QU7K2JBT

NONCE=$(aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID | \
        jq -r '.ResourceRecordSets[] | select(.Name == "nonce.vichex.ca.").ResourceRecords[0].Value')
NONCE=$(echo $NONCE | sed 's,",,g')

echo Old vichex.ca Nonce: $NONCE
NONCE=$(($NONCE + 1))
echo New vichex.ca Nonce: $NONCE

JSON="$(cat <<EOF
    {
      "Changes": [
        {
          "Action": "UPSERT",
          "ResourceRecordSet": {
            "Name": "nonce.vichex.ca",
            "Type": "TXT",
            "TTL": 300,
            "ResourceRecords": [
              {
                "Value": "\"$NONCE\""
              }
            ]
          }
        }
      ]
    }
EOF
)"

echo $JSON

aws route53 change-resource-record-sets \
  --hosted-zone-id $HOSTED_ZONE_ID \
  --change-batch "$JSON" | cat
