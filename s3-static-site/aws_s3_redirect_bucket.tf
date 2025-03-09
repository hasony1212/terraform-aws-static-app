
# This file creates a bucket that redirects all requests to the main site bucket
resource "aws_s3_bucket_policy" "bucket-static-site-redirect-policy" {
  bucket = "${aws_s3_bucket.bucket-static-site-redirect.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSSLRequestsOnly",
            "Action": "s3:*",
            "Effect": "Deny",
            "Resource": [
              "${aws_s3_bucket.bucket-static-site-redirect.arn}"
            ],
            "Condition": {
              "Bool": {
                "aws:SecureTransport": "false"
              }
            },
            "Principal": "*"
          }
    ]
}
POLICY
}

#creating the bucket that redirects all requests to the main site bucket
resource "aws_s3_bucket" "bucket-static-site-redirect" {
  bucket = "www.${var.domain}"
  tags   = var.tags

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    redirect_all_requests_to = "${aws_s3_bucket.bucket-static-site.id}"
  }
}

#creating the public access block for the bucket
resource "aws_s3_bucket_public_access_block" "bucket-static-site-redirect" {
  bucket = aws_s3_bucket.bucket-static-site-redirect.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
