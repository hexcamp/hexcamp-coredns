#! /bin/sh

set -euxo pipefail

export AWS_PROFILE=default

# seahex.org
HOSTED_ZONE_ID=Z067634225NKASXQ5OWP6

NONCE=$(aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID | \
        jq -r '.ResourceRecordSets[] | select(.Name == "nonce.seahex.org.").ResourceRecords[0].Value')
NONCE=$(echo $NONCE | sed 's,",,g')

echo Old seahex.org Nonce: $NONCE
NONCE=$(($NONCE + 1))
echo New seahex.org Nonce: $NONCE

JSON="$(cat <<EOF
    {
      "Changes": [
        {
          "Action": "UPSERT",
          "ResourceRecordSet": {
            "Name": "nonce.seahex.org",
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
