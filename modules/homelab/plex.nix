{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  service = "plex";
  cfg = config.homelab.${service};
in {
  options.homelab.${service} = {
    enabled = mkEnableOption "Whether to enable ${service}.";
    port = mkOption int 32400 "The port to use for ${service}.";
    subdomain = mkOption str "${service}" "The subdomain to use for ${service}.";
  };

  config = mkIf cfg.enable {
    services = {
      plex = {
        enable = true;
        openFirewall = true;
      };

      caddy.virtualHosts = {
        "${cfg.subdomain}.${homelab.domain}".extraConfig = ''
          reverse_proxy http://127.0.0.1:${cfg.port}
        '';
      };
    };
  };
}
