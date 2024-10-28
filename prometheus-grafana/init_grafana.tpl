#cloud-config


package_update: true
# package_upgrade: true

packages:
  - git

write_files:
- content: |
    #!/bin/bash
    echo "  - job_name: 'Pushgateway'" >> /var/snap/prometheus/86/prometheus.yml
    echo "    honor_labels: true" >> /var/snap/prometheus/86/prometheus.yml
    echo "    static_configs:" >> /var/snap/prometheus/86/prometheus.yml
    echo "      - targets: ['localhost:9091']" >> /var/snap/prometheus/86/prometheus.yml
  path: /opt/prometheus.sh
  permissions: '0755'
- content: |
    #!/bin/bash
    for i in /opt/deploy/esp-data-collection-srv/grafana_cfg/datasources/*; do \
        curl -X "POST" "http://localhost:3000/api/datasources" \
        -H "Content-Type: application/json" \
         --user admin:admin \
         --data-binary @$i
    done

    for i in /opt/deploy/esp-data-collection-srv/grafana_cfg/dashboards/*; do \
        curl -X "POST" "http://localhost:3000/api/dashboards/db" \
        -H "Content-Type: application/json" \
         --user admin:admin \
         --data-binary @$i
    done
  path: /opt/grafana.sh
  permissions: '0755'

runcmd:
 - [ sh, -c, "snap install grafana" ]
 - [ sh, -c, "sleep 1" ]
 - [ sh, -c, "snap install prometheus" ]
 - [ sh, -c, "sleep 1" ]
 - [ sh, -c, "snap install prometheus-pushgateway" ]
 - [ sh, -c, "sleep 1" ]
 - [ sh, "/opt/prometheus.sh" ]
 - [ sh, -c, "snap restart prometheus.prometheus" ]
 - [ sh, -c, "sleep 1" ]
 - [ mkdir, -p, /opt/deploy/ ]
 - [ git, clone, "https://github.com/bespsm/esp-data-collection-srv.git", /opt/deploy/esp-data-collection-srv ]
 - [ sh, -c, "sleep 1" ]
 - [ sh, "/opt/grafana.sh" ]