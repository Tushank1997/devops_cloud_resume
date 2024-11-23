#variables terraform file

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "web_domain_name" {
  type        = string
  description = "Website domain name (FQDN)."
}

