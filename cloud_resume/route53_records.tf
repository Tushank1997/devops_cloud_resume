#Adding dns records to Route53 hosted zone. 

#Route53 domain name dns record for cloudfront distribution

resource "aws_route53_record" "sub_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = trimsuffix(var.web_domain_name, ".tushank.com")
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_cloudfront_distribution.s3_website_distribution.domain_name}"]
}

# ACM certificate validation DNS record

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = ["${each.value.record}"]
}