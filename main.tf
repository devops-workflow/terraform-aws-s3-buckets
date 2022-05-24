##
## terraform-aws-s3-buckets
##

# TODO: Allow pass policy via variable. Default empty policy. If can be done, otherwise 2 modules
# create s3 bucket and set policy
# TODO:
#   support w. or w/o encryption (AES|KMS)
#   use boolean for var.public

# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket.html
# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket_policy.html
# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket_notification.html
# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket_object.html

module "enabled" {
  source  = "devops-workflow/boolean/local"
  version = "0.1.2"
  value   = "${var.enabled}"
}

module "labels" {
  source        = "appzen-oss/labels/null"
  version       = "0.2.0"
  attributes    = "${var.attributes}"
  component     = "${var.component}"
  delimiter     = "${var.delimiter}"
  enabled       = "${module.enabled.value}"
  environment   = "${var.environment}"
  monitor       = "${var.monitor}"
  names         = "${var.names}"
  namespace-env = "${var.namespace-env}"
  namespace-org = "${var.namespace-org}"
  organization  = "${var.organization}"
  owner         = "${var.owner}"
  product       = "${var.product}"
  service       = "${var.service}"
  tags          = "${var.tags}"
  team          = "${var.team}"
}

locals {
  encryption_def = {
    "true" = [{
      rule = [{
        apply_server_side_encryption_by_default = [{
          sse_algorithm     = "${var.kms_master_key_arn != "" ? "aws:kms" : "AES256"}"
          kms_master_key_id = "${var.kms_master_key_arn}"
        }]
      }]
    }]

    "false" = []
  }

  server_side_encryption_configuration = "${local.encryption_def[var.encryption]}"
}

## if encryption is false then create bucket without encryption
resource "aws_s3_bucket" "this" {
  count = "${module.enabled.value ? length(var.names) : 0 }"

  bucket        = "${module.labels.id[count.index]}"
  acl           = "${var.public ? "public-read" : "private"}"
  force_destroy = "${var.force_destroy}"

  versioning {
    enabled = "${var.versioned}"
  }

  server_side_encryption_configuration = "${local.server_side_encryption_configuration}"

  #acceleration_status
  #lifecycle_rule {}
  #logging {
  #  target_bucket
  #  target_prefix
  #}
  #region = "${var.region}"
  #request_payer
  #replication_configuration {}


  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm   = "${var.sse_algorithm}"
  #       kms_master_key_id = "${var.kms_master_key_arn}"
  #     }
  #   }
  # }

  tags = "${module.labels.tags[count.index]}"
}

resource "aws_s3_bucket_public_access_block" "this" {
  depends_on              = ["aws_s3_bucket.this"]
  count                   = "${module.enabled.value ? length(var.names) : 0}"
  bucket                  = "${module.labels.id[count.index]}"
  block_public_acls       = "${var.block_public_acls}"
  block_public_policy     = "${var.block_public_policy}"
  ignore_public_acls      = "${var.ignore_public_acls}"
  restrict_public_buckets = "${var.restrict_public_buckets}"
}

# data "template_file" "policy_s3_bucket" {
#   # TODO: add condition to select public or private template
#   #   or 2 data and condition in policy for which data to use
#   template = "${file("${path.module}/files/policy_s3_bucket.json")}"
#   vars = {
#     name  = "${aws_s3_bucket.this.bucket}"
#     principal = "${var.principal}"
#   }
# }

# resource "aws_s3_bucket_policy" "bucket_policy" {
#   count   = "${module.enabled.value ? length(var.names) : 0}"
#   bucket  = "${module.labels.id[count.index]}"  
#   #bucket = "${aws_s3_bucket.this.id}"
#   policy = "${data.template_file.policy_s3_bucket.rendered}"
# }

# https://aws.amazon.com/blogs/security/how-to-prevent-uploads-of-unencrypted-objects-to-amazon-s3/
data "aws_iam_policy_document" "bucket_policy" {
  count = "${module.enabled.value && var.allow_encrypted_uploads_only == "true" ? length(var.names) : 0}"

  statement {
    sid       = "DenyIncorrectEncryptionHeader"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${module.labels.id[count.index]}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "StringNotEquals"
      values   = ["${var.kms_master_key_arn != "" ? "aws:kms" : "AES256"}"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }

  statement {
    sid       = "DenyUnEncryptedObjectUploads"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${module.labels.id[count.index]}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "Null"
      values   = ["true"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }

  statement {
    sid       = "BucketOwnerFullAccess"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${module.labels.id[count.index]}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "StringNotEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
}

resource "aws_s3_bucket_policy" "default" {
  depends_on = ["aws_s3_bucket.this"]
  count      = "${module.enabled.value && var.allow_encrypted_uploads_only == "true" ? length(var.names) : 0}"
  bucket     = "${module.labels.id[count.index]}"
  policy     = "${element(data.aws_iam_policy_document.bucket_policy.*.json, count.index)}"

  #policy = "${join("", data.aws_iam_policy_document.bucket_policy.*.json, count.index)}"
}

#resource "aws_s3_bucket_notification"


/*
resource "aws_s3_bucket_object" "this" {
  count   = "${length(var.files)}"
  bucket  = "${aws_s3_bucket.this.id}"
  key     = "${element(keys(var.files), count.index)}"
  #source  = "${lookup(var.files, element(keys(var.files), count.index))}"
  etag    = "${md5(file("${lookup(var.files, element(keys(var.files), count.index))}"))}"
}
*/

