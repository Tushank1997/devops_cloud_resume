#AWS Managed-CachingOptimized caching policy id

data "aws_cloudfront_cache_policy" "aws_cache_policy" {
  name = "Managed-CachingOptimized"
}

data "aws_route53_zone" "hosted_zone" {
  name = "tushank.com."
}
