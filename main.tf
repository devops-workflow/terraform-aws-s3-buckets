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

resource "aws_s3_bucket" "this" {
  count = "${length(var.names)}"
  bucket = "${var.namespaced ?
   format("%s-%s-%s", var.org, var.environment, element(var.names, count.index)) :
   format("%s-%s", var.org, element(var.names, count.index))}"
  acl = "${var.public ? public-read : private}"
  versioning {
    enabled = "${var.versioned}"
  }
  #acceleration_status
  #force_destroy = true
  #lifecycle_rule {}
  #logging {
  #  target_bucket
  #  target_prefix
  #}
  #region
  #request_payer
  #replication_configuration {}
  tags = "${ merge(
    var.tags,
    map("Name", var.namespaced ?
     format("%s-%s-s3-bucket", var.environment, element(var.names, count.index)) :
     format("%s-s3-bucket", element(var.names, count.index)) ),
    map("Environment", var.environment),
    map("Terraform", "true") )}"
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
