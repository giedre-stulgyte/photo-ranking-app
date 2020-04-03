#!/bin/bash

pushd . # Store current directory

# Set up virtual environment 
cd ../infrastructure/scripts
source install_venv.sh
source configure_aws_environment.sh

cd ../../frontend/photo-ranking-app

export FRONTEND_BUCKET_NAME_URL="s3://${APP_NAME}-frontend"
export PHOTO_UPLOAD_BUCKET="s3://${APP_NAME}-photo-upload"
export USER_POOL_ID=$(npx aws-cdk-output --name="${APP_NAME}-user-pool-id" --fromStack="BackendStack")
export APP_CLIENT_ID=$(npx aws-cdk-output --name="${APP_NAME}-user-pool-client-id" --fromStack="BackendStack")
export IDENTITY_POOL_ID=$(npx aws-cdk-output --name="${APP_NAME}-identity-pool-id" --fromStack="BackendStack")
# export API_GATEWAY_URL= // TODO

npm run build && aws s3 sync build/ ${FRONTEND_BUCKET_NAME_URL}

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory