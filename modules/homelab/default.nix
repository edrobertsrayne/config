{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.homelab;
in {
  options.homelab = {
    enable = mkEnableOption "Whether to enable the homelab.";
    domain = mkOption types.str "greensroad.uk" "The domain to use for the homelab.";
  };

  config = mkIf cfg.enable {
    imports = [
      ./blocky.nix
      ./caddy.nix
      ./plex.nix
    ];
  };
}
