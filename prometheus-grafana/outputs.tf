# output.tf

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_ip" {
  value = aws_instance.this.public_ip
}

output "public-zone-id" {
  value = aws_route53_zone.this.zone_id
}

output "name-servers" {
  value = aws_route53_zone.this.name_servers
}
