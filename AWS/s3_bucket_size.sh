#!/bin/bash
# List all buckets and their size. It uses current profile.

  buckets=($(aws --region <REGION> s3 ls s3:// --recursive | awk '{print $3}'))

  #loop S3 buckets
  for j in "${buckets[@]}"; do
  echo "${j}"
  aws --region <REGION> s3 ls s3://"${j}" --recursive --human-readable --summarize | awk END'{print}'
  done
