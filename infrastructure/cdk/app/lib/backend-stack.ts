import * as cdk from '@aws-cdk/core';
import dynamodb = require('@aws-cdk/aws-dynamodb');
import s3 = require('@aws-cdk/aws-s3');
import cognito = require('@aws-cdk/aws-cognito')
import { VerificationEmailStyle, UserPool } from '@aws-cdk/aws-cognito';
import { Duration } from '@aws-cdk/core';

interface MultiStackProps extends cdk.StackProps {
  resourcePrefix: string;
}

export class BackendStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props: MultiStackProps) {
    super(scope, id, props);

    var photoUploadBucketName = props.resourcePrefix + "-photo-upload";
    var dynamoDbTableName = props.resourcePrefix + "-table";
    var cognitoUserPoolName = props.resourcePrefix + "-user-pool";
    var cognitoUserPoolClientName = props.resourcePrefix + "-user-pool-client";

    const s3Bucket = new s3.Bucket(this, photoUploadBucketName, {
    	bucketName: photoUploadBucketName
    });

    const dynamoDb = new dynamodb.Table(this, dynamoDbTableName, {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING }
    });

    const userPool = new cognito.UserPool(this, cognitoUserPoolName, {
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

    const userPoolClientProps : cognito.UserPoolClientProps = {
      userPoolClientName: cognitoUserPoolClientName,
      userPool: userPool,
      generateSecret: true
    };

    const cognitoUserPoolClient = new cognito.UserPoolClient(this, cognitoUserPoolClientName, userPoolClientProps);

  }
}