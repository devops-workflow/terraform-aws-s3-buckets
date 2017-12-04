
module "s3-none" {
  source      = ".."
  names       = []
  environment = "${var.environment}"
  org         = "${var.organization}"
}

module "s3-single" {
  source      = ".."
  names       = ["bucket"]
  environment = "${var.environment}"
  org         = "${var.organization}"
}

module "s3-multi" {
  source      = ".."
  names       = ["bucket-1", "bucket2", "bucket_3"]
  environment = "${var.environment}"
  org         = "${var.organization}"
}
