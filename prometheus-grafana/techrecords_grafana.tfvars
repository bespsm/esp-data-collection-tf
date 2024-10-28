# techrecords_grafana.tfvars 

tag                 = "esp-dc-grafana"
location            = "eu-central-1"
instance_type       = "t2.micro"
domain_link         = "YOURDOMAINNAME.COM"
subdomain_link      = "YOURSUBDOMAINDOMAINNAMEFORMQTTSERVER.COM"
cloud_config        = "init_grafana.tpl"