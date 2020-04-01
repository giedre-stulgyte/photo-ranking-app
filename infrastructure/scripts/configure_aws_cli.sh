#!/bin/bash

# AWS Credentials
read -p "AWS Account ID ($( [  ! -z $AWS_ACCOUNT_ID ] && echo *********${AWS_ACCOUNT_ID:(-3)})): " aws_account_id
if [ ! -z ${aws_account_id} ]; then
	export AWS_ACCOUNT_ID=${aws_account_id}
elif [ -z $AWS_ACCOUNT_ID ]; then 
	echo "Missing AWS account ID; Aborting"; 
	return
fi

read -p "AWS Access Key ID ($( [  ! -z $AWS_ACCESS_KEY_ID ] && echo *********${AWS_ACCESS_KEY_ID:(-3)})): " aws_access_key_id
if [ ! -z ${aws_access_key_id} ]; then
	export AWS_ACCESS_KEY_ID=${aws_access_key_id}
elif [ -z $AWS_ACCESS_KEY_ID ]; then 
	echo "Missing AWS access key ID; Aborting"; 
	return
fi

read -p "AWS Secret Access Key ($( [  ! -z $AWS_SECRET_ACCESS_KEY ] && echo *********${AWS_SECRET_ACCESS_KEY:(-3)})): " aws_secret_access_key
if [ ! -z ${aws_secret_access_key} ]; then
	export AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}
elif [ -z $AWS_SECRET_ACCESS_KEY ]; then 
	echo "Missing AWS secret access key; Aborting"; 
	return
fi

read -p "AWS Region ($( [  ! -z $AWS_REGION ] && echo ${AWS_REGION})): " aws_region
if [ ! -z ${aws_region} ]; then
	export AWS_REGION=${aws_region}
elif [ -z $AWS_REGION ]; then 
	echo "Missing AWS region; Aborting"; 
	return
fi

aws configure

return 1