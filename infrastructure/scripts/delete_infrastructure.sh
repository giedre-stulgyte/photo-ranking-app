#!/bin/bash

pushd . # Store current directory

# Set up virtual environment 
source install_venv.sh
source configure_aws_environment.sh

cd ../cdk/app
echo "Installing Node modules..."
npm install

echo "Tearing down frontend stack..."
FRONTEND_BUCKET="${APP_NAME}-frontend"
aws s3 rb "s3://${FRONTEND_BUCKET}" --force
cdk destroy 'FrontendStack' -f 

echo "Tearing down backend stack..."
PHOTO_UPLOAD_BUCKET="${APP_NAME}-photo-upload"
aws s3 rb "s3://${PHOTO_UPLOAD_BUCKET}" --force
cdk destroy 'BackendStack' -f

echo "Tearing down the CDK Toolkit..."
cdk_staging_bucket=$(aws s3 ls --region ${AWS_REGION} | grep cdktoolkit | awk '{print $3}')
aws s3 rb s3://${cdk_staging_bucket} --force
aws cloudformation delete-stack --stack-name CDKToolkit

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory