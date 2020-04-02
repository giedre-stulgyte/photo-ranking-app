#!/bin/bash

pushd . # Store current directory

# Set up virtual environment 
cd scripts
source install_venv.sh
source configure_aws_environment.sh

cd ../../frontend/photo-ranking-app
FRONTEND_BUCKET_NAME_URL="s3://${APP_NAME}-frontend"
npm run build && aws s3 sync build/ ${FRONTEND_BUCKET_NAME_URL}

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory