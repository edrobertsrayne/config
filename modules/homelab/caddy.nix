{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  service = "caddy";
  cfg = config.homelab.${service};
in {
  options.homelab.${service} = {
    enable = mkEnableOption "Whether to enable ${service}.";
  };

  config = mkIf cfg.enable {
    services.caddy = enabled;
    networking.firewall.allowedTCPPorts = [80 443];
  };
}
