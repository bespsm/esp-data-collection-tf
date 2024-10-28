#cloud-config


package_update: true
# package_upgrade: true

packages:
  - python3-pip
  - python3-paho-mqtt
  - python3-boto3
  - mosquitto
  - mosquitto-clients
  - git
  - libsystemd-dev
  - python3-systemd
  - openssl

write_files:
- content: |
    -----BEGIN CERTIFICATE-----
    PUT HERE YOUR CA CERTIFICATE FOR MQTT SERVER
    -----END CERTIFICATE-----
  owner: root:root
  permissions: '0664'
  path: /opt/ca.crt
- content: |
    -----BEGIN CERTIFICATE-----
    PUT HERE YOUR CLIENT CERITFICATE FOR MQTT SERVER
    -----END CERTIFICATE-----
  owner: root:root
  permissions: '0664'
  path: /opt/client.crt
- content: |
    -----BEGIN PRIVATE KEY-----
    PUT HERE YOUR PRIVATE KEY FOR MQTT SERVER
    -----END PRIVATE KEY-----
  owner: root:root
  permissions: '0664'
  path: /opt/client.key
- content: |
    [Unit]
    Description=Forwards all MQTT messages to DynamoDB
    After=network.target
    Wants=network.target

    [Service]
    ExecStart=/bin/bash -c 'exec /opt/deploy/esp-data-collection-srv/script/mqtt_nosql_bridge_ssl.py'
    Type=notify
    Environment="AWS_DEFAULT_REGION=eu-central-1"
    Environment="CA_CRT=/opt/ca.crt"
    Environment="CLIENT_CRT=/opt/client.crt"
    Environment="CLIENT_KEY=/opt/client.key"
    Environment="MQTT_URI="YOURSUBDOMAINDOMAINNAMEFORMQTTSERVER.COM"

    [Install]
    WantedBy=multi-user.target
  owner: root:root
  permissions: '0664'
  path: /lib/systemd/system/mqtt-nosql-bridge.service

runcmd:
 - [ sh, -c, "sleep 1" ]
 - [ mkdir, -p, /opt/deploy/ ]
 - [ git, clone, "https://github.com/bespsm/esp-data-collection-srv.git", /opt/deploy/esp-data-collection-srv ]
 - [ sh, -c, "sleep 1" ]
 - [ chmod, 755, /opt/deploy/esp-data-collection-srv/script/mqtt_nosql_bridge_ssl.py ]
 - [ sh, -c, "systemctl daemon-reload" ]
 - [ sh, -c, "systemctl enable mosquitto" ]
 - [ sh, -c, "systemctl start mosquitto" ]
 - [ sh, -c, "sleep 1" ]
 - [ sh, -c, "systemctl enable mqtt-nosql-bridge" ]
 - [ sh, -c, "systemctl start mqtt-nosql-bridge" ]