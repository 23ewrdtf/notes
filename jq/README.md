https://0xdf.gitlab.io/2018/12/19/jq.html

Export from CloudFormation VPC stack subnet IDs

```
aws --region <REGION> cloudformation describe-stack-resources --stack-name <STACK NAME> | jq '.StackResources[] | select(.LogicalResourceId | contains("Subnet0")) | .PhysicalResourceId' | sed 's/"//g' | grep -vi rtbassoc```
