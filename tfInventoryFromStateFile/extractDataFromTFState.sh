#!/usr/bin/env bash
tfStateFilePath=$1
readarray -t aws_resource_types < <(jq -r '[.resources[] ] | map(.type) | unique ' $tfStateFilePath)

#for each resource type, create a CSV formatted table 
rm tfResourceInventory.csv
echo -e "Resource type,Name in TF,ARN,ID" >> tfResourceInventory.csv
for aws_resource_type in "${aws_resource_types[@]}"
do
  
  if [[ "$aws_resource_type" == "[" ||  "$aws_resource_type" == "]" ]]; then
    echo "skip"
  else
    export temp=$(echo $aws_resource_type | tr -d '",')
    (echo -e "\n" ; jq -r --arg temp "${temp}"  '[.resources[] | select(.type==$temp)] | .[] | [ .type, .name, .instances[0].attributes.arn, .instances[0].attributes.id] |@csv' $tfStateFilePath | tr -d '"' ; ) >> tfResourceInventory.csv
  fi
  
done 
