#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { AppStack } from '../lib/app-stack';
import { DatabaseStack } from '../lib/database-stack';
import { FrontendStack } from '../lib/frontend-stack';

appName = process.env.APP_NAME;
bucketName = appName + "bucket";

const app = new cdk.App();
// new AppStack(app, 'AppStack');
// new DatabaseStack (app, 'DatabaseStack')
new FrontendStack (app, 'FrontendStack', {
	bucketName: bucketName;
})

app.synth()