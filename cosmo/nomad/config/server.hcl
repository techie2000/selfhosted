server {
  enabled = true
  bootstrap_expect = 3
  server_join {
    retry_join = [ "maco.vpn.dcotta.eu", "ari.vpn.dcotta.eu" ]
    retry_max = 3
    retry_interval = "15s"
  }
}

data_dir  = "/var/lib/nomad"

bind_addr = "10.8.0.1"
#bind_addr = "127.0.0.1"

advertise {
#   Defaults to the first private IP address.
  http = "10.8.0.1"
  rpc  = "10.8.0.1"
  serf = "10.8.0.1" # non-default ports may be specified
}

log_rotate_bytes = 1024000

ports {
  http = 4646
  rpc  = 4647
  serf = 4648
}

telemetry {
  collection_interval = "5s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
