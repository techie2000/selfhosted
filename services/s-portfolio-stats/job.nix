let
  lib = import ../../jobs/lib;
  version = "f7029bd";
  name = "s-web-portfolio";
  cpu = 120;
  mem = 500;
  ports = {
    http = 8888;
    grpc = 8081;
    upDb = 5432;
    upS3 = 3333;
  };
  sidecarResources = with builtins; mapAttrs (_: ceil) {
    cpu = 0.20 * cpu;
    memoryMB = 0.25 * mem;
    memoryMaxMB = 0.25 * mem + 100;
  };
  otlpPort = 9001;
  bind = lib.localhost;
in
lib.mkJob name {
  update = {
    maxParallel = 1;
    autoRevert = true;
    autoPromote = true;
    canary = 1;
  };

  group.${name} = {
    count = 1;
    network = {
      mode = "bridge";
      dynamicPorts = [
        { label = "metrics"; }
      ];
      reservedPorts = [
      ];
    };

    service.${name} = rec {
      connect.sidecarService = {
        proxy = {
          upstream."tempo-otlp-grpc-mesh".localBindPort = otlpPort;

          config = lib.mkEnvoyProxyConfig {
            otlpService = "proxy-${name}";
            otlpUpstreamPort = otlpPort;
            protocol = "http";
          };
        };
      };
      connect.sidecarTask.resources = sidecarResources;
      # TODO implement http healthcheck
      port = toString ports.http;
      meta.metrics_port = "\${NOMAD_HOST_PORT_metrics}";
      meta.metrics_path = "/metrics";
      checks = [{
        expose = true;
        name = "metrics";
        portLabel = "metrics";
        type = "http";
        path = meta.metrics_path;
        interval = 10 * lib.seconds;
        timeout = 3 * lib.seconds;
      }];
      tags = [
        "traefik.enable=true"
        "traefik.consulcatalog.connect=true"
        "traefik.http.routers.\${NOMAD_GROUP_NAME}-com.tls=true"
        "traefik.http.routers.\${NOMAD_GROUP_NAME}.entrypoints=web, websecure"
      ];
    };
    service."${name}-grpc" = {
      connect.sidecarService = {
        proxy = {
          config = lib.mkEnvoyProxyConfig {
            otlpService = "proxy-${name}";
            otlpUpstreamPort = otlpPort;
            protocol = "grpc";
          };
        };
      };
      connect.sidecarTask.resources = sidecarResources;
      port = toString ports.grpc;
    };

    task.${name} = {
      driver = "docker";
      vault = { };

      config = {
        image = "ghcr.io/cottand/selfhosted/${name}:${version}";
      };
      env = {
        HTTP_HOST = bind;
        HTTP_PORT = toString ports.http;
      };
      resources = {
        cpu = cpu;
        memoryMb = mem;
        memoryMaxMb = builtins.ceil (2 * mem);
      };
    };
  };
}
