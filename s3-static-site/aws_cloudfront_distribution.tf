resource "aws_cloudfront_origin_access_control" "current" {
  name                              = "OAC ${aws_s3_bucket.bucket-static-site.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


#Create the CDN
resource "aws_cloudfront_distribution" "s3_distribution" {

  depends_on = [aws_s3_bucket.bucket-static-site]
  origin {
    domain_name = "${aws_s3_bucket.bucket-static-site.bucket_regional_domain_name}"
    origin_id   = "${var.domain}-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.current.id
  }

  comment         = "${var.domain} distribution"
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${var.domain}-logs.s3.amazonaws.com"
    prefix          = "myprefix"
  }

  #aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.domain}-origin"

    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # AWS-provided 'CachingDisabled' cache policy

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }



  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "IN"]
    }
  }

  tags = var.tags

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}
