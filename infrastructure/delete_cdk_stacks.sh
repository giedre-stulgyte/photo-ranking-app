#!/bin/bash

pushd . # Store current directory

# Set up virtual environment 
source scripts/install_venv.sh
source scripts/configure_aws_environment.sh

cd cdk/app
echo "Installing Node modules..."
npm install

echo "Tearing down the CDK Toolkit..."
cdk_staging_bucket=$(aws s3 ls --region ${AWS_REGION} | grep cdktoolkit | awk '{print $3}')
aws s3 rb s3://${cdk_staging_bucket} --force
aws cloudformation delete-stack --stack-name CDKToolkit

echo "Tearing down frontend stack..."
cdk destroy 'FrontendStack' -f
# Deactivate Python virtual environment
deactivate
cd ..

echo "Done! Virtual environment deactivated."
popd # Return to directory