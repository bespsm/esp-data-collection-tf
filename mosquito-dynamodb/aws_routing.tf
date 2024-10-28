# aws_routing.tf

resource "aws_route53_zone" "this" {
  name    = var.domain_link
  comment = "${var.domain_link} public zone"
}

resource "aws_route53_record" "mqtt-ns" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.subdomain_mqtt_link
  type    = "A"
  ttl     = "300"
  records = [aws_instance.this.public_ip]
}
