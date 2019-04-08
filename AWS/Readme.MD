`aws configure --profile <profile-name>` to configure profiles so below files will end up like that

Example:

```
cat ~/.aws/config
[profile1]
region = eu-west-2
output = json
[profile2]
region = eu-west-1
output = json
```

```
cat ~/.aws/credentials
[profile1]
aws_access_key_id = KEY_ID
aws_secret_access_key = ACCESS_KEY
[profile2]
aws_access_key_id = KEY_ID
aws_secret_access_key = ACCESS_KEY
```

Then do `export AWS_PROFILE=profile-name` to use this profile with awscli and kubectl.

After that `aws sts get-caller-identity` should get you your identity you will be using to connect to AWS.

Now this should work `aws eks list-clusters` this will show eks clusters in the current region. 

For another region do  `aws eks list-clusters --region eu-west-1`

```
{
    "clusters": [
        "eks-test"
    ]
}
```

Kubectl


```kubectl cluster-info
Kubernetes master is running at https://..........eks.amazonaws.com
CoreDNS is running at https://..........eks.amazonaws.com/...
To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

Every kubectl command you run will apply to above cluster.



```
***************************************************************************************************
***************************************************************************************************
```

Add custom cloudwatch check to EC2 instance

Add `CloudWatchAgentServerPolicy` policy to a new role and attach to the vm you want to monitor or add `CloudWatchAgentServerPolicy` policy to current role already attached to the vm you want to monitor.

Login to VM

Create a folder
`mkdir amazon-cloudwatch-agent`

`cd amazon-cloudwatch-agent`

Download Agent
`wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm`

Install Agent
`sudo rpm -U ./amazon-cloudwatch-agent.rpm`

`cd /opt/aws/amazon-cloudwatch-agent/bin`

Use wizard to configure it `sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
` OR copy `config.json` / `config_disk_ram.json` from this repo

`sudo nano config.json`

`sudo nano config_disk_ram.json`


Start Agent
`sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:config_disk_ram.json -s`

Status Agent
`sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status`

Stop Agent
`sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a stop`

After a few minutes you should be able to see it coming in CloudWatch Metrics.









