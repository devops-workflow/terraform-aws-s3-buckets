
output "arn" {
  description = "List of AWS S3 Bucket ARNs"
  value = "${aws_s3_bucket.this.*.arn}"
}
output "domain_name" {
  description = "List of AWS S3 Bucket Domain Names"
  value = "${aws_s3_bucket.this.*.bucket_domain_name}"
}
output "hosted_zone_id" {
  description = "List of AWS S3 Bucket Hosted Zone IDs"
  value = "${aws_s3_bucket.this.*.hosted_zone_id}"
}
output "id" {
  description = "List of AWS S3 Bucket IDs"
  value       = "${aws_s3_bucket.this.*.id}"
}
output "name" {
  description = "List of AWS S3 Bucket Names"
  value = "${aws_s3_bucket.this.*.id}"
}
output "region" {
  description = "List of AWS S3 Bucket Regions"
  value = "${aws_s3_bucket.this.*.region}"
}

#aws_s3_bucket_object.this.id
#aws_s3_bucket_object.this.etag
#aws_s3_bucket_object.this.version_id
