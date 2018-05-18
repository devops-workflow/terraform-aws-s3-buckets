module "s3" {
  source       = "../../"
  names        = ["bucket-1", "bucket2", "bucket_3"]
  environment  = "${var.environment}"
  organization = "${var.organization}"
}

data "aws_iam_policy_document" "s3" {
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = ["${formatlist("%s/*", module.s3.arns)}"]
  }
}
