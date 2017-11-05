/**
 * AWS S3 Terraform Module
 * =====================
 *
 * Create AWS S3 bucket and set policy
 *
 * Usage:
 * ------
 *
 *     module "s3" {
 *       source       = "../tf_s3"
 *       name         = "apps"
 *       environment  = "dev01"
 *     }
**/

# TODO: Allow pass policy via variable. Default empty policy. If can be done, otherwise 2 modules
# create s3 bucket and set policy
resource "aws_s3_bucket" "bucket" {
  #bucket = "dmp-rpns-${var.s3_env_map[var.env]}"
  # TODO: Setup namespaced condition
  bucket = "${format("%s-%s", var.environment, var.name)}"
  acl = "private"
  versioning {
    enabled = true
  }
  tags = "${ merge(
    var.tags,
    map("Name", var.namespaced ?
     format("%s-%s-s3-bucket", var.environment, var.name) :
     format("%s-s3-bucket", var.name) ),
    map("Environment", var.environment),
    map("Terraform", "true") )}"
}
/*
data "template_file" "policy_s3_bucket" {
  template = "${file("${path.module}/files/policy_s3_bucket.json")}"
  vars = {
    name  = "${aws_s3_bucket.bucket.bucket}"
    principal = "${var.principal}"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = "${data.template_file.policy_s3_bucket.rendered}"
}
*/
