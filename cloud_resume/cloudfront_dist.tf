#AWS cloudfront distribution

resource "aws_cloudfront_distribution" "s3_website_distribution" {
  origin {
    domain_name = aws_s3_bucket.web_s3_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket_website_configuration.website.website_endpoint
  }

  aliases = ["${var.web_domain_name}"]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Static S3 website cloudfront distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket_website_configuration.website.website_endpoint
    cache_policy_id  = data.aws_cloudfront_cache_policy.aws_cache_policy.id


    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Environment = "Static Website"
  }

  viewer_certificate {
    # cloudfront_default_certificate = true
    acm_certificate_arn = aws_acm_certificate.ssl_certificate.arn
    ssl_support_method  = "sni-only"
  }
}