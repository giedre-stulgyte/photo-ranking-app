#!/bin/bash

pushd . # Store current directory

# Set up virtual environment
source install_venv.sh
source configure_aws_credentials.sh
source deploy_infrastructure.sh

# Deactivate Python virtual environment
deactivate

echo "Done! Virtual environment deactivated."
popd # Return to directory