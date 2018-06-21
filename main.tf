/**
 * AWS S3 Bucket Terraform Module
 * =====================
 *
 * Create multiple AWS S3 buckets and set policies
 *
 * Usage:
 * ------
 * '''hcl
 *     module "s3-bucket" {
 *       source       = "../s3-bucket"
 *       names        = ["images","thumbnails"]
 *       environment  = "dev"
 *       org          = "corp"
 *     }
 * '''
**/

# TODO: Allow pass policy via variable. Default empty policy. If can be done, otherwise 2 modules
# create s3 bucket and set policy
# TODO: setup encryption

# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket.html
# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket_policy.html
# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket_notification.html
# https://www.terraform.io/docs/providers/aws/r/aws_s3_bucket_object.html

module "enabled" {
  source  = "devops-workflow/boolean/local"
  version = "0.1.1"
  value   = "${var.enabled}"
}

module "labels" {
  source        = "devops-workflow/labels/null"
  version       = "0.1.0"
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

resource "aws_s3_bucket" "this" {
  count = "${module.enabled.value ? length(var.names) : 0}"

  bucket        = "${module.labels.id[count.index]}"
  acl           = "${var.public ? "public-read" : "private"}"
  force_destroy = "${var.force_destroy}"

  versioning {
    enabled = "${var.versioned}"
  }

  #acceleration_status
  #lifecycle_rule {}
  #logging {
  #  target_bucket
  #  target_prefix
  #}
  #region
  #request_payer
  #replication_configuration {}
  #server_side_encryption_configuration
  tags = "${module.labels.tags[count.index]}"
}

/*
data "template_file" "policy_s3_bucket" {
  # TODO: add condition to select public or private template
  #   or 2 data and condition in policy for which data to use
  template = "${file("${path.module}/files/policy_s3_bucket.json")}"
  vars = {
    name  = "${aws_s3_bucket.this.bucket}"
    principal = "${var.principal}"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.this.id}"
  policy = "${data.template_file.policy_s3_bucket.rendered}"
}
*/


#resource "aws_s3_bucket_notification"


/*
resource "aws_s3_bucket_object" "this" {
  count   = "${length(var.files)}"
  bucket  = "${aws_s3_bucket.this.id}"
  key     = "${element(keys(var.files), count.index)}"
  source  = "${lookup(var.files, element(keys(var.files), count.index))}"
  etag    = "${md5(file("${lookup(var.files, element(keys(var.files), count.index))}"))}"
}
*/

