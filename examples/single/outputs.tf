output "arns" {
  description = "List of AWS S3 Bucket ARNs"
  value       = "${module.s3.arns}"
}

output "domain_names" {
  description = "List of AWS S3 Bucket Domain Names"
  value       = "${module.s3.domain_names}"
}

output "hosted_zone_ids" {
  description = "List of AWS S3 Bucket Hosted Zone IDs"
  value       = "${module.s3.hosted_zone_ids}"
}

output "ids" {
  description = "List of AWS S3 Bucket IDs"
  value       = "${module.s3.ids}"
}

output "names" {
  description = "List of AWS S3 Bucket Names"
  value       = "${module.s3.names}"
}

output "regions" {
  description = "List of AWS S3 Bucket Regions"
  value       = "${module.s3.regions}"
}
