`aws configure --profile <profile-name>` to configure profiles so below files will end up like that

Example:

```
cat ~/.aws/config
[profile1]
region = eu-west-2
output = json
```

```
cat ~/.aws/credentials
[profile2]
aws_access_key_id = KEY_ID
aws_secret_access_key = ACCESS_KEY
```

Then do `export AWS_PROFILE=profile-name` to use this profile with aws command

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

export KUBECONFIG=$KUBECONFIG:~/.kube/config.txt
