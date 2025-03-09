#this file creates the bucket that will store the logs for the cloudfront distribution

#this policy allows cloudfront to write logs to the bucket
resource "aws_s3_bucket_policy" "bucket-logst-policy" {
  bucket = "${aws_s3_bucket.bucket-logs.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CloudForntAccessLogsWrite",
      "Action": "s3:PutObject",
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket-logs.arn}/*"
      ],
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
        }
      },
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      }
    },
    {
      "Sid": "AllowSSLRequestsOnly",
      "Action": "s3:*",
      "Effect": "Deny",
      "Resource": [
        "${aws_s3_bucket.bucket-logs.arn}"
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

#ccreating the bucket that will store the logs for the cloudfront distribution
resource "aws_s3_bucket" "bucket-logs" {
  bucket = "${var.domain}-logs"
  #acl = "log-delivery-write"

  versioning {
    enabled = true
  }

  tags   = var.tags
}

#creating the public access block for the bucket
resource "aws_s3_bucket_public_access_block" "bucket-logs" {
  bucket = aws_s3_bucket.bucket-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
#creating the bucket ownership controls for the bucket
resource "aws_s3_bucket_ownership_controls" "cloudfront_logs" {
  bucket = aws_s3_bucket.bucket-logs.id

  rule {
    object_ownership = "BucketOwnerPreferred" # Allows ACLs
  }
}

# Add this new resource
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-logs-encryption" {
  bucket = aws_s3_bucket.bucket-logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

