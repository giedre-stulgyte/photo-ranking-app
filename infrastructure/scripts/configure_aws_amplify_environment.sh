#!/bin/bash

echo "Setting AWS Amplify environment variables..."

if [ -z ${AWS_ACCOUNT_ID} ]; then
	echo "Missing AWS credentials. Please refer to the README before running this script again. Aborting"; 
	return
else
    export FRONTEND_BUCKET_NAME_URL="s3://${APP_NAME}-frontend"
    export PHOTO_UPLOAD_BUCKET="s3://${APP_NAME}-photo-upload"
    export USER_POOL_ID=$(npx aws-cdk-output --name="${APP_NAME}-user-pool-id" --fromStack="BackendStack")
    export APP_CLIENT_ID=$(npx aws-cdk-output --name="${APP_NAME}-user-pool-client-id" --fromStack="BackendStack")
    export IDENTITY_POOL_ID=$(npx aws-cdk-output --name="${APP_NAME}-identity-pool-id" --fromStack="BackendStack")
fi