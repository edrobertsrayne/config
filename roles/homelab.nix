{lib, ...}: let
  inherit (lib.custom) enabled;
in {
  homelab = {
    enable = true;
    blocky = enabled;
    caddy = enabled;
    plex = enabled;
  };
}
