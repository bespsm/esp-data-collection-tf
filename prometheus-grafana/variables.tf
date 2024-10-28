# techrecords_ssl.tf

variable "vpc_cidr" {
  default = "10.27.0.0/16"
}

variable "public_subnet" {
  default = "10.27.1.0/24"
}

variable "tag" {
  type        = string
  description = "The project tag"
}

variable "location" {
  type        = string
  description = "The project region"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "domain_link" {
  type        = string
  description = "Owned domain name"
}

variable "subdomain_link" {
  type        = string
  description = "URL to subdomain"
}

variable "cloud_config" {
  type        = string
  description = "Name of the init-cloud config to deploy"
}
