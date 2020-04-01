#!/bin/bash

# Set up Python virtual environment
cd cdk
source install_venv.sh
cd ..


# Configure environment variablescd cdk
source scripts/configure_aws_cli.sh
source scripts/set_aws_app_name.sh

# Deploy CDK applicaation to AWS
cd cdk
echo -e "Deploying CDK toolkit stack..."
cdk bootstrap aws://${AWS_ACCOUNT_ID}/${AWS_REGION}

npm run build
# cdk deploy DatabaseStack

echo -e "Deploying CDK frontend stack..."
cdk deploy FrontendStack

# Deactivate Python virtual environment
deactivate
cd ..