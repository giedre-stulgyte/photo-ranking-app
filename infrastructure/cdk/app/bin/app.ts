#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { BackendStack } from '../lib/backend-stack';
import { FrontendStack } from '../lib/frontend-stack';

const app = new cdk.App();

const AWSResourcePrefix = process.env.APP_NAME || "default-resource-name";

new BackendStack (app, 'BackendStack', {
	resourcePrefix: AWSResourcePrefix
})

new FrontendStack (app, 'FrontendStack', {
	resourcePrefix: AWSResourcePrefix
})

app.synth()
