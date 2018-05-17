module "s3" {
  source       = "../../"
  names        = ["disabled"]
  environment  = "${var.environment}"
  organization = "${var.organization}"
  enabled      = false
}
