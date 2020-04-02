(work in progress)

Compatibility:

- macOS (Catalina), Windows
- Not tested with Linux

Pre-requisites:

- AWS account
- AWS IAM user with a pair of access credentials
	- Permissions: 
		- AmazonS3FullAccess
		- AWSCloudFormationFullAccess
- Python3
- Pip3
- npm 6 or later

To deploy: 

cd infrastructure

source deploy_to_aws.sh
