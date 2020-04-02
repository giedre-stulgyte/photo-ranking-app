import * as cdk from '@aws-cdk/core';
import s3 = require('@aws-cdk/aws-s3');
import iam = require ('@aws-cdk/aws-iam');
import { BucketAccessControl, BlockPublicAccess } from '@aws-cdk/aws-s3';

interface MultiStackProps extends cdk.StackProps {
  resourcePrefix: string;
}

export class FrontendStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props: MultiStackProps) {
    super(scope, id, props);

    const frontendBucketName = props.resourcePrefix + "-frontend";

    const frontendBucket = new s3.Bucket(this, frontendBucketName, {
      bucketName: frontendBucketName,
      websiteIndexDocument: "index.html",
      websiteErrorDocument: "index.html",
      accessControl: BucketAccessControl.PUBLIC_READ,
      blockPublicAccess: new BlockPublicAccess ({
        blockPublicAcls: false,
        blockPublicPolicy: false,
        ignorePublicAcls: false, 
        restrictPublicBuckets: false
      })
    });

    const publicAccessPolicy = new iam.PolicyStatement({
      actions: ["s3:GetObject"],
      effect: iam.Effect.ALLOW,
      resources: [frontendBucket.arnForObjects("*")],
      principals: [new iam.AnyPrincipal()]
    });

    frontendBucket.addToResourcePolicy(publicAccessPolicy);
    
  }
}