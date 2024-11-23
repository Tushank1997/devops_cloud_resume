#Provision SSL certificate using AWS certificate manager service. 

resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = var.web_domain_name
  validation_method = "DNS"
  key_algorithm     = "RSA_2048"

  lifecycle {
    create_before_destroy = true
  }
}

#validating ACM provisioned certificate. 

resource "aws_acm_certificate_validation" "validate_ssl_cert" {
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for val in aws_route53_record.cert_validation : val.fqdn]
}