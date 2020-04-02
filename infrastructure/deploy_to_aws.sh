#!/bin/bash

pushd . # Store current directory

# Set up virtual environment 
source scripts/install_venv.sh
source scripts/configure_aws_environment.sh

cd cdk/app
echo "Installing Node modules..."
# npm install
npm install --save aws-cdk@1.31.0
npm install --save @aws-cdk/core @aws-cdk/aws-s3 @aws-cdk/aws-lambda @aws-cdk/aws-apigateway

echo -e "Deploying CDK toolkit stack..."
cdk bootstrap aws://${AWS_ACCOUNT_ID}/${AWS_REGION}

# Deploy CDK constructs to AWS
# npm run build
# # cdk deploy DatabaseStack

echo -e "Deploying CDK frontend stack..."
cdk deploy FrontendStack

# Deactivate Python virtual environment
deactivate
cd ..

echo "Done! Virtual environment deactivated."
popd # Return to directory