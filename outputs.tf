output "arns" {
  description = "List of AWS S3 Bucket ARNs"
  value       = "${aws_s3_bucket.this.*.arn}"
}

output "domain_names" {
  description = "List of AWS S3 Bucket Domain Names"
  value       = "${aws_s3_bucket.this.*.bucket_domain_name}"
}

output "hosted_zone_ids" {
  description = "List of AWS S3 Bucket Hosted Zone IDs"
  value       = "${aws_s3_bucket.this.*.hosted_zone_id}"
}

output "ids" {
  description = "List of AWS S3 Bucket IDs"
  value       = "${aws_s3_bucket.this.*.id}"
}

output "name_bases" {
  description = "List of base names used to generate S3 bucket names"
  value       = "${var.names}"
}

output "names" {
  description = "List of AWS S3 Bucket Names"
  value       = "${aws_s3_bucket.this.*.id}"
}

output "regions" {
  description = "List of AWS S3 Bucket Regions"
  value       = "${aws_s3_bucket.this.*.region}"
}

#aws_s3_bucket_object.this.id
#aws_s3_bucket_object.this.etag
#aws_s3_bucket_object.this.version_id

