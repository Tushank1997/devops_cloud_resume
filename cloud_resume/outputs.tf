#outputs displayed on terminal window

output "bucket_name" {
  value = aws_s3_bucket.web_s3_bucket.id
}

output "bucket_domain" {
  value = aws_s3_bucket.web_s3_bucket.bucket_regional_domain_name
}

output "bucket_url" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "acm_cert_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
}

output "id_cache_policy" {
  value = data.aws_cloudfront_cache_policy.aws_cache_policy.id
}

output "cloudfront_dist_name" {
  value = aws_cloudfront_distribution.s3_website_distribution.domain_name
}

output "zone_id" {
  value = data.aws_route53_zone.hosted_zone.id
}

output "cert_status" {
  value = aws_acm_certificate.ssl_certificate.status
}

output "website_url" {
  value = var.web_domain_name
}
