#this file is used to create the s3 bucket for the static site

#calling the aws_caller_identity to get the account id
data "aws_caller_identity" "current" {}

#creating the s3 bucket policy 
resource "aws_s3_bucket_policy" "website-bucket-policy" {
  bucket = "${aws_s3_bucket.bucket-static-site.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipalReadOnly",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.bucket-static-site.arn}/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                }
            }

        }, 
        {
            "Sid": "AllowSSLRequestsOnly",
            "Action": "s3:*",
            "Effect": "Deny",
            "Resource": [
              "${aws_s3_bucket.bucket-static-site.arn}"
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

#creating the s3 bucket for static site
resource "aws_s3_bucket" "bucket-static-site" {
  bucket = var.domain
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
    index_document = "index.html"
    error_document = "404.html"
  }

}


#creating the s3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "bucket-static-site" {
  bucket = aws_s3_bucket.bucket-static-site.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#creating the s3 bucket public access block
resource "aws_s3_bucket_public_access_block" "bucket-static-site" {
  bucket = aws_s3_bucket.bucket-static-site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}