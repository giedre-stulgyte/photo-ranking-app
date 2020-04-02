#!/bin/bash

pushd . # Store current directory

# Set up virtual environment
source install_venv.sh
source configure_aws_environment.sh

cd ../cdk/app
echo "Installing Node modules..."
npm install

# TODO: Delete below
# npm install --save aws-cdk@1.31.0
# npm install --save @aws-cdk/core @aws-cdk/aws-s3 @aws-cdk/aws-iam @aws-cdk/aws-lambda @aws-cdk/aws-apigateway @aws-cdk/aws-cognito @aws-cdk/aws-dynamodb

echo -e "Deploying CDK toolkit stack..."
cdk bootstrap aws://${AWS_ACCOUNT_ID}/${AWS_REGION}

# Deploy CDK constructs to AWS

echo -e "Deploying CDK backend stack..."
cdk deploy BackendStack

echo -e "Deploying CDK frontend stack..."
cdk deploy FrontendStack

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory