[![CircleCI](https://circleci.com/gh/appzen-oss/terraform-aws-s3-buckets.svg?style=svg)](https://circleci.com/gh/appzen-oss/terraform-aws-s3-buckets)
[![Github release](https://img.shields.io/github/release/appzen-oss/terraform-aws-s3-buckets.svg)](https://github.com/appzen-oss/terraform-aws-s3-buckets/releases)

# AWS S3 Buckets Terraform module

Terraform module which creates S3 buckets on AWS.

Terraform Registry: https://registry.terraform.io/modules/devops-workflow/s3-buckets/aws

Usage
-----

```hcl
module "s3-buckets" {
  source       = "devops-workflow/s3-buckets/aws"
  names        = ["bucket1", "bucket2", "bucket3"]
  environment  = "dev"
  organization = "corp"
}
```

This would create/manage 3 S3 buckets: `corp-dev-bucket1`, `corp-dev-bucket2`, and `corp-dev-bucket3`

If a S3 bucket already exists, you will need to import it. Like this:

```Shell
terraform import module.s3-buckets.aws_s3_bucket.this[0] corp-dev-bucket1
```
