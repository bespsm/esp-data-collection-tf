# techrecords_auth.tfvars 

tag                 = "esp-dc-auth"
location            = "eu-central-1"
instance_type       = "t2.micro"
domain_link         = "YOURDOMAINNAME.COM"
subdomain_mqtt_link = "YOURSUBDOMAINDOMAINNAMEFORMQTTSERVER.COM"
cloud_config        = "init_auth.tpl"
esp_db_name         = "espData"