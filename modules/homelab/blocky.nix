{
  lib,
  config,
  ...
}:
with lib; let
  service = "blocky";
  cfg = config.homelab.${service};
in {
  options.homelab.${service} = {
    enable = mkEnableOption "Whether to enable ${service}.";
  };

  config = mkIf cfg.enable {
    services.blocky = {
      enable = true;
      settings = {
        ports.dns = 53;
        ports.http = 4000;
        upstreams.groups.default = [
          "https://one.one.one.one/dns-query"
        ];
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };
        caching = {
          minTime = "5m";
          maxTime = "30m";
          prefetching = true;
        };
        blocking = {
          blackLists = {
            ads = [
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            ];
          };
          whiteLists = {
            ads = [
              "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt"
            ];
          };
        };
        prometheus = {
          enable = true;
          path = "/metrics";
        };
      };
    };

    networking.firewall = {
      allowedTCPPorts = [53 4000];
      allowedUDPPorts = [53];
    };
  };
}
