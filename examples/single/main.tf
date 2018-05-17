module "s3" {
  source       = "../../"
  names        = ["bucket"]
  environment  = "${var.environment}"
  organization = "${var.organization}"
}
