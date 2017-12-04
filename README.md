AWS S3 Buckets Terraform module
========================

Terraform module which creates S3 buckets on AWS.

Usage
-----

```hcl
module "s3-buckets" {
  source      = "devops-workflow/s3-buckets/aws"
  names       = ["bucket-1", "bucket2", "bucket_3"]
  environment = "dev"
  org         = "corp"
}
```
