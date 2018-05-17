module "s3" {
  source       = "../../"
  names        = ["bucket-1", "bucket2", "bucket_3"]
  environment  = "${var.environment}"
  organization = "${var.organization}"
}
