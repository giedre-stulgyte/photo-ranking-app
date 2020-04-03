export default {
    s3: {
      REGION: process.env.AWS_REGION,
      BUCKET: process.env.PHOTO_UPLOAD_BUCKET
    },
    // apiGateway: {
    //   REGION: process.env.AWS_REGION,
    //   URL: process.env.API_GATEWAY_URL
    // },
    cognito: {
      REGION: process.env.AWS_REGION,
      USER_POOL_ID: process.env.USER_POOL_ID,
      APP_CLIENT_ID: process.env.APP_CLIENT_ID,
      IDENTITY_POOL_ID: process.env.IDENTITY_POOL_ID
    }
  };