#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { AppStack } from '../lib/app-stack';
import { BackendStack } from '../lib/backend-stack';
import { FrontendStack } from '../lib/frontend-stack';

const app = new cdk.App();

const bucketName = process.env.APP_NAME + "-bucket";

// new AppStack(app, 'AppStack');
// new BackendStack (app, 'BackendStack')
new FrontendStack (app, 'FrontendStack', {
	s3BucketName: bucketName
})

app.synth()