#!/bin/bash

pushd . # Store current directory

# Set up virtual environment 
cd ../infrastructure/scripts
source install_venv.sh
source configure_aws_environment.sh
source configure_aws_amplify_environment.sh

cd ../../frontend/photo-ranking-app

# export API_GATEWAY_URL= // TODO

npm run build && aws s3 sync build/ ${FRONTEND_BUCKET_NAME_URL}

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory