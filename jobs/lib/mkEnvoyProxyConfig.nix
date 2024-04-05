{
  otlpService,
  otlpUpstreamPort,
}:
{
  protocol = "http";
  envoy_tracing_json = ''
    {
       "http": {
                "name": "envoy.tracers.opentelemetry",
                "typed_config": {
                    "@type": "type.googleapis.com/envoy.config.trace.v3.OpenTelemetryConfig",
                    "grpc_service": {
                        "envoy_grpc": {
                            "cluster_name": "opentelemetry_collector"
                        },
                        "timeout": "0.250s"
                    },
                    "service_name": "${otlpService}"
                }
            }
    }
  '';

  envoy_extra_static_clusters_json = ''
    {
        "name": "opentelemetry_collector",
        "type": "STRICT_DNS",
        "lb_policy": "ROUND_ROBIN",
        "typed_extension_protocol_options": {
            "envoy.extensions.upstreams.http.v3.HttpProtocolOptions": {
                "@type": "type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions",
                "explicit_http_config": {
                    "http2_protocol_options": {}
                }
            }
        },
        "load_assignment": {
            "cluster_name": "opentelemetry_collector",
            "endpoints": [
                {
                    "lb_endpoints": [
                        {
                            "endpoint": {
                                "address": {
                                    "socket_address": {
                                        "address": "127.0.0.1",
                                        "port_value": ${toString otlpUpstreamPort}
                                    }
                                }
                            }
                        }
                    ]
                }
            ]
        }
    }
  '';
}
