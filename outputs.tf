// AWS S3 Bucket Name
output "s3_bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}

// AWS S3 Bucket ARN
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}
// AWS S3 Bucket Domain Name
output "s3_bucket_domain_name" {
  value = "${aws_s3_bucket.bucket.bucket_domain_name}"
}
// AWS S3 Bucket Region
output "s3_bucket_region" {
  value = "${aws_s3_bucket.bucket.region}"
}
// AWS S3 Bucket ID
output "s3_bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}
// AWS S3 Bucket Hosted Zone ID
output "s3_bucket_hosted_zone_id" {
  value = "${aws_s3_bucket.bucket.hosted_zone_id}"
}
