import * as cdk from '@aws-cdk/core';
import s3 = require('@aws-cdk/aws-s3');

interface MultiStackProps extends cdk.StackProps {
  s3BucketName: string;
}

export class FrontendStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props: MultiStackProps) {
    super(scope, id, props);

    new s3.Bucket(this, props.s3BucketName, {
    	bucketName: props.s3BucketName
    });
  }
}