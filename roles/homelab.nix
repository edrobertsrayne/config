{lib, ...}: let
  inherit (lib.custom) enabled;
in {
  homelab = {
    blocky = enabled;
  };
}
