
module "s3-single" {
  source      = ".."
  names       = ["bucket"]
  environment = "${var.environment}"
  org         = "zapter"
}

module "s3-multi" {
  source      = ".."
  names       = ["bucket-1", "bucket2", "bucket_3"]
  environment = "${var.environment}"
  org         = "zapter"
}
