
output "bucket-name" {
  description = "The name of the main S3 bucket."
  value       = "${aws_s3_bucket.bucket-static-site.bucket}"
}
