#!/bin/bash

cd ../cdk/app
echo "Installing Node modules..."
npm install

echo -e "Deploying CDK toolkit stack..."
cdk bootstrap aws://${AWS_ACCOUNT_ID}/${AWS_REGION}

# Deploy CDK constructs to AWS

echo -e "Deploying CDK backend stack..."
cdk deploy BackendStack

echo -e "Deploying CDK frontend stack..."
cdk deploy FrontendStack