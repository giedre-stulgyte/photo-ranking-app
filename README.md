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
		- AmazonDynamoDBFullAccess
		- (custom) IAM: CreateRole, DeleteRolePolicy, PutRolePolicy
- Python3
- Pip3
- npm 6 or later

To deploy: 

- cd deploy
- source deploy_infrastructure.sh
- source deploy_frontent.sh
