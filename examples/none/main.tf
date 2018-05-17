module "s3" {
  source       = "../../"
  names        = []
  environment  = "${var.environment}"
  organization = "${var.organization}"
}
