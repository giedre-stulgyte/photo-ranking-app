#!/bin/bash

# Set up Python virtual environment
cd cdk
source install_venv.sh
cd ..


source scripts/configure_aws_environment.sh

# Deploy CDK applicaation to AWS
cd cdk/app
echo -e "Deploying CDK toolkit stack..."
cdk bootstrap aws://${AWS_ACCOUNT_ID}/${AWS_REGION}

# npm run build
# # cdk deploy DatabaseStack

# echo -e "Deploying CDK frontend stack..."
# cdk deploy FrontendStack

# Deactivate Python virtual environment
deactivate
cd ..

echo "Done! Virtual environment deactivated."