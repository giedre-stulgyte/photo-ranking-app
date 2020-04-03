#!/bin/bash

pushd . # Store current directory

# Set up virtual environment
source install_venv.sh
source configure_aws_environment.sh

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

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory