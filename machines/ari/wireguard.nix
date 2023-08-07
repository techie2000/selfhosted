{ config, pkgs, ... }:
{
  # Enable WireGuard
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.8.0.8/24" ];
      #listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      privateKeyFile = "/root/secret/wg-private.key";

      dns = [ "1.1.1.1" ];

      peers = [
        {
          publicKey = "Nn6nM3ykE5TfYzRgnTCPAsiaVCV9QmKHvbscrPdhcms=";
          presharedKey = "v/X4KYrjVsfqszt8Ae4ivM2OvjXQ2o6D1MjFBv1AbfQ=";

          # Forward all the traffic via VPN.
          #              allowedIPs = [ "0.0.0.0/0" ];
          # traffic not routed through cosmo
          allowedIPs = [ "10.8.0.0/24" ];

          endpoint = "vps.dcotta.eu:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
