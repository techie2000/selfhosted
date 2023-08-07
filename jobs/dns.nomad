job "dns" {
    datacenters = ["dc1"]
    type        = "system"
    group "blocky-dns" {
        network {
            mode = "bridge"
            port "dns" {
                static       = 53
                host_network = "vpn"
            }
            port "dns-mesh" {
                static       = 53
                host_network = "wg-mesh"
            }
                        // port "dns-public" {
                        //     static = 53
                        // }
            port "metrics" {
                to           = 4000
                host_network = "vpn"
            }
        }


        service {
            name     = "dns-metrics"
            provider = "nomad"
            port     = "metrics"
            tags     = [
                "metrics",
            ]
        }
        service {
            name     = "dns"
            provider = "nomad"
            port     = "dns"
            check {
                name     = "alive"
                type     = "tcp"
                port     = "metrics"
                interval = "20s"
                timeout  = "2s"
            }
        }
        service {
            name     = "dns-mesh"
            provider = "nomad"
            port     = "dns-mesh"
            check {
                name     = "alive"
                type     = "tcp"
                port     = "metrics"
                interval = "20s"
                timeout  = "2s"
            }
        }
        task "blocy-dns" {
            driver = "docker"
            config {
                image   = "spx01/blocky"
                volumes = [
                    "local/config.yml:/app/config.yml",
                ]
                ports = ["dns", "metrics"]
            }
            env = {
                "environment" = "TZ=Europe/Berlin"
            }
            resources {
                cpu    = 80
                memory = 80
            }
            template {
                data        = <<EOF
port: {{ env "NOMAD_PORT_dns"  }}
httpPort: {{ env "NOMAD_PORT_metrics" }}
upstream:
  default:
    # DNS over TCP https://blog.uncensoreddns.org/dns-servers/
    - 91.239.100.100:843
    - 9.9.9.9
    - 1.1.1.1
#    - https://dns.digitale-gesellschaft.ch/dns-query

customDNS:
  customTTL: 5m
  rewrite:
    vps.dcotta.eu: cosmo.vps
    web.vps.dcotta.eu: cosmo.vps
    seaweed-filer.vps.dcotta.eu: cosmo.vps
    l.dcotta.eu: cosmo.vps
  mapping:
    # address of traefik + wg network. Requests to this IP will hit the traefik proxy which will route
    # containers appropriately
    cosmo.vps: 10.8.0.1
    maco.vps: 10.8.0.5
    ari.vps: 10.8.0.8
    elvis.vps: 10.8.0.101
    
    {{ range $i, $s := nomadService "seaweedfs-webdav" }}
    {{ if eq $i 0 }}
    webdav.vps: {{ .Address }}
    {{ end }}
    {{ end }}

    {{ range $i, $s := nomadService "seaweedfs-master-http" }}
    {{ if eq $i 0 }}
    seaweedfs-master.vps: {{ .Address }}
    {{ end }}
    {{ end }}

    {{ range $i, $s := nomadService "seaweedfs-filer-http" }}
    {{ if eq $i 0 }}
    seaweedfs-filer.vps: {{ .Address }}
    {{ end }}
    {{ end }}

blocking:
  blackLists:
    ads:
      - https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
      - https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/black.list
  clientGroupsBlock:
    default:
      - ads

prometheus:
  enable: true
EOF
                destination = "local/config.yml"
            }
        }
    }
}