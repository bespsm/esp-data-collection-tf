# TERRAFORM CONFIGS FOR ESP DATA COLLECTION PROJECT

This repository contains terraform configs for AWS backend server and its init-config files. The configs create VPC, instantiate EC2 server, add the routings, open needed ports, assign public DNS name for EC2 instance. There are 3 different configurations for ESP data collection:

### MQTT Mosquitto & Auth + DynamoDB (non visual)
- creates DynamoDB database (adapt [techrecords_auth.tfvars](mosquito-dynamodb/techrecords_auth.tfvars)) to store ESP data
- deploys to EC2 Eclipse Mosquitto MQTT broker and enables access to it by user:password authentication (adapt [init_auth.tpl](mosquito-dynamodb/init_auth.tpl))
- deploys to EC2 [mqtt_nosql_bridge_auth.py](https://github.com/bespsm/esp-data-collection-srv/blob/main/script/mqtt_nosql_bridge_auth.py) script that forwards all MQTT messages to DynamoDB database
```
cd mosquito-dynamodb/
terraform init
terraform apply -var-file=techrecords_auth.tfvars
```

### MQTT Mosquitto & TLS + DynamoDB (non visual)
- creates DynamoDB database (adapt [techrecords_ssl.tfvars](mosquito-dynamodb/techrecords_ssl.tfvars)) to store ESP data
- deploys to EC2 Eclipse Mosquitto MQTT broker and enables access to it TLS (adapt [init_ssl.tpl](mosquito-dynamodb/init_ssl.tpl))
- deploys to EC2 [mqtt_nosql_bridge_ssl.py](https://github.com/bespsm/esp-data-collection-srv/blob/main/script/mqtt_nosql_bridge_ssl.py) script that forwards all MQTT messages to DynamoDB database
```
cd mosquito-dynamodb/
terraform init
terraform apply -var-file=techrecords_ssl.tfvars
```

### Prometheus Pushgateway + Prometheus + Grafana
- deploys to EC2 grafana, configures prometheus as datasource, creates dashboard to visualise ESP data (adapt [techrecords_grafana.tfvars)](prometheus-grafana/techrecords_grafana.tfvars))
- deploys to EC2 prometheus and prometheus-pushgateway
```
cd prometheus-grafana/
terraform init
terraform apply -var-file=techrecords_grafana.tfvars
```

***Please adapt `.tfvars` variables files and `.tpl` init-cloud files before applying for it.***

License
=======

MIT License, see [LICENSE](LICENSE).