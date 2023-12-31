const AWS = require('aws-sdk');

module.exports = {
	aws: AWS,
	s3: new AWS.S3({
    region: 'us-east-1',
    accessKeyId: 'AKIATSML2437GL2SDLFU',
    secretAccessKey: '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',
  })
};
