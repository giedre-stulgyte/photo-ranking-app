## Run using "source install_venv"

ENVIRONMENT="$(uname -s)"

setPythonVersion() {

  echo "Setting the Python version to Python 3..."

  if [[ "$(python --version)" =~ "Python 3." ]]; then
      PYTHON=python
      PIP=pip
    else
      PYTHON=python3
      PIP=pip3
    fi

    echo "Finished setting the Python version."
}

if [[ ${ENVIRONMENT} =~ "Darwin" ]]; then
	BIN_PATH="./venv/bin"
	PYTHON=python3
  PIP=pip3
elif [[ ${ENVIRONMENT} =~ "Linux" ]]; then
    BIN_PATH="./venv/bin"
    setPythonVersion
elif [[ ${ENVIRONMENT} =~ "MINGW" ]]; then
    BIN_PATH="./venv/Scripts"
    setPythonVersion
else
    echo "Unknown environment: $ENVIRONMENT"
    exit 1
fi

echo "Activating virtual environment..."
${PYTHON} -m venv venv
. ${BIN_PATH}/activate
echo "Successfully activated virtual environment."

echo "Installing dependencies..."
${PIP} install awscli
# # npm install
# npm install --save typescript
# npm install --save aws-cdk@1.31.0
# npm install --save @aws-cdk/core @aws-cdk/aws-s3 @aws-cdk/aws-lambda @aws-cdk/aws-apigateway
echo -e "Successfully installed dependencies."