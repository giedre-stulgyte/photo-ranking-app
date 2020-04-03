import * as cdk from '@aws-cdk/core';
import dynamodb = require('@aws-cdk/aws-dynamodb');
import s3 = require('@aws-cdk/aws-s3');
import cognito = require('@aws-cdk/aws-cognito')
import { VerificationEmailStyle, UserPool, AuthFlow } from '@aws-cdk/aws-cognito';
import { Duration } from '@aws-cdk/core';

interface MultiStackProps extends cdk.StackProps {
  resourcePrefix: string;
}

export class BackendStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props: MultiStackProps) {
    super(scope, id, props);

    // AWS Resources IDs
    const photoUploadBucketName = props.resourcePrefix + "-photo-upload";
    const dynamoDbTableName = props.resourcePrefix + "-table";
    const cognitoUserPoolName = props.resourcePrefix + "-user-pool";
    const cognitoUserPoolClientName = props.resourcePrefix + "-user-pool-client";
    const cognitoUserPoolDomainName = props.resourcePrefix;
    const cognitoIdentityPoolName = props.resourcePrefix + "-identity-pool";
    const cognitoUserPoolAdminGroupName = props.resourcePrefix + "-admin";

    // Output IDs
    const cognitoUserPoolIdOutput = cognitoUserPoolName + "-id";
    const cognitoClientIdOutput = cognitoUserPoolClientName + "-id";
    const cognitoIdentityPoolIdOutput = cognitoIdentityPoolName + "-id";

    const photoUploadBucket = new s3.Bucket(this, photoUploadBucketName, {
    	bucketName: photoUploadBucketName
    });

    const dynamoDb = new dynamodb.Table(this, dynamoDbTableName, {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING }
    });

    const cognitoUserPool = new cognito.UserPool(this, cognitoUserPoolName, {
      userPoolName: cognitoUserPoolName, 
      selfSignUpEnabled: true,
      signInAliases: { username: true, email: true},
      passwordPolicy: {
        minLength: 8,
        requireLowercase: true,
        requireUppercase: true,
        requireDigits: true,
        requireSymbols: true,
        tempPasswordValidity: Duration.days(3),
      },
      userInvitation: {
        emailSubject: 'Invite to join our awesome app!',
        emailBody: 'Hello {username}, you have been invited to join our awesome app! Your temporary password is {####}'
      },
      userVerification: {
        emailSubject: 'Verify your email for our awesome app!',
        emailBody: 'Hello {username}, Thanks for signing up to our awesome app! Your verification code is {####}',
        emailStyle: VerificationEmailStyle.CODE
      }
    });

    const cognitoUserPoolClient = new cognito.UserPoolClient(this, cognitoUserPoolClientName, {
      userPoolClientName: cognitoUserPoolClientName,
      userPool: cognitoUserPool,
      generateSecret: true,
      enabledAuthFlows: [
        AuthFlow.ADMIN_NO_SRP,
        AuthFlow.USER_PASSWORD
      ]}
    );

    const cognitoUserPoolDomain = new cognito.CfnUserPoolDomain(this, cognitoUserPoolDomainName, {
      domain: cognitoUserPoolDomainName,
      userPoolId: cognitoUserPool.userPoolId
    });


    // TODO: Add roles (API Gateway needs ot be setup first)
    const cognitoIdentityPool = new cognito.CfnIdentityPool(this, cognitoIdentityPoolName, {
      identityPoolName: cognitoIdentityPoolName,
      allowUnauthenticatedIdentities: false,
      cognitoIdentityProviders: [{
        clientId: cognitoUserPoolClient.userPoolClientId,
        providerName: cognitoUserPool.userPoolProviderName,
        serverSideTokenCheck: true
      }] 
    });

    const adminUserGroup = new cognito.CfnUserPoolGroup(this, cognitoUserPoolAdminGroupName, {
      userPoolId: cognitoUserPool.userPoolId,
      groupName: cognitoUserPoolAdminGroupName
    });

    const cognitoUserPoolId = new cdk.CfnOutput(this, cognitoUserPoolIdOutput, {
      value: cognitoUserPool.userPoolId,
      exportName: cognitoUserPoolIdOutput,
      description: "Cognito User Pool ID"
    }); 

    const cognitoClientId = new cdk.CfnOutput(this, cognitoClientIdOutput, {
      value: cognitoUserPoolClient.userPoolClientId,
      exportName: cognitoClientIdOutput,
      description: "Cognito App Client ID"
    });

    const cognitIdentityPoolId = new cdk.CfnOutput(this, cognitoIdentityPoolIdOutput, {
      value: cognitoIdentityPool.ref,
      exportName: cognitoClientIdOutput,
      description: "Cognito Identity Pool ID"
    }); 
  }
}