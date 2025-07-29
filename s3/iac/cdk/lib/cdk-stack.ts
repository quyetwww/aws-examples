import { Duration, Stack, StackProps, RemovalPolicy} from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3';

import { Construct } from 'constructs';

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    const bucket = new s3.Bucket(this, 'MyFirstBucket', {
      bucketName: `my-app-${this.account}-${this.region}`,
      blockPublicAccess: s3.BlockPublicAccess.BLOCK_ALL,
      versioned: true,
      lifecycleRules: [
        {
          id: 'expire-old-objects',
          expiration: Duration.days(365),
        },
      ],
      removalPolicy: RemovalPolicy.DESTROY, // ⚠️ chỉ nên dùng ở môi trường dev/test
      autoDeleteObjects: true,
    });
  }
}
