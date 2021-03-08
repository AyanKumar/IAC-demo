resource "aws_route53_record" "harbor-external" {
  name    = local.external_dns
  type    = "A"
  zone_id = "/hostedzone/${var.hostedzone_id}"
  records = aws_instance.harbor.*.private_ip
  ttl     = "300"
}