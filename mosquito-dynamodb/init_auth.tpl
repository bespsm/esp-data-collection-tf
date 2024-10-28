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

write_files:
- content: |
    listener 1883
    allow_anonymous false
    password_file /etc/mosquitto/passwd
  owner: root:root
  permissions: '0664'
  path: /etc/mosquitto/conf.d/mosquitto.conf
- content: |
    [Unit]
    Description=Forwards all mqtt messages to DynamoDB
    After=network.target
    Wants=network.target

    [Service]
    ExecStart=/bin/bash -c 'exec /opt/deploy/esp-data-collection-srv/script/mqtt_nosql_bridge_auth.py'
    Type=notify
    Environment="USER_ID=espuser"
    Environment="USER_PASS=myesppass"
    Environment="AWS_DEFAULT_REGION=eu-central-1"

    [Install]
    WantedBy=multi-user.target
  owner: root:root
  permissions: '0664'
  path: /lib/systemd/system/mqtt-nosql-bridge.service
- content: |
    espuser:$7$101$qZagG/+3wEeGIJ+p$vX2HnQDMQhbLqxvO/k/HS3a+CAAs8LG8ZKZSVoKFucnCmBVOYsMOh0S5YXmmV5wgLjIyfXKsGHqG+5uNEeXu8A==
  owner: root:root
  permissions: '0664'
  path: /etc/mosquitto/passwd

runcmd:
 - [ sh, -c, "sleep 1" ]
 - [ mkdir, -p, /opt/deploy/ ]
 - [ git, clone, "https://github.com/bespsm/esp-data-collection-srv.git", /opt/deploy/esp-data-collection-srv ]
 - [ sh, -c, "sleep 1" ]
 - [ chmod, 755, /opt/deploy/esp-data-collection-srv/script/mqtt_nosql_bridge_auth.py ]
 - [ sh, -c, "systemctl daemon-reload" ]
 - [ sh, -c, "systemctl enable mosquitto" ]
 - [ sh, -c, "systemctl start mosquitto" ]
 - [ sh, -c, "sleep 1" ]
 - [ sh, -c, "systemctl enable mqtt-nosql-bridge" ]
 - [ sh, -c, "systemctl start mqtt-nosql-bridge" ]