resource "aws_route53_record" "cname_route53_record" {
  zone_id = "Z04094123DETTKTIAWK4N"
  name    = "superset.knohrslab.com" # Replace with your subdomain, Note: not valid with "apex" domains, e.g. example.com
  type    = "CNAME"
  ttl     = "60"
  records = [aws_alb.main.dns_name]
}
