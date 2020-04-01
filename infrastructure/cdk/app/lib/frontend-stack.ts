import * as cdk from '@aws-cdk/core';

export class FrontendStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new s3.Bucket(this, 'MyFirstBucket', {
    	bucketName: props.bucketName
    });
  }
}