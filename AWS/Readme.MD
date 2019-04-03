aws configure --profile <profile-name>

edit ~/.aws/config and ~/.aws/credentials:

Example:

cat ~/.aws/config
[profile1]
region = eu-west-2
output = json

cat ~/.aws/credentials
[profile2]
aws_access_key_id = KEY_ID
aws_secret_access_key = ACCESS_KEY
