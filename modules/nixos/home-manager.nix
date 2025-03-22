{
  lib,
  config,
  inputs,
  ...
}:
with lib.custom; let
  cfg = config.modules.home-manager;
in {
  options.modules.home-manager = {
    enable = mkEnableOption "Whether to enable the home-manager module.";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.modules.user.name} = import ../home;
      sharedModules = [
        inputs.nvf.homeManagerModules.default
        {
          programs.home-manager = enabled;
          manual = {
            manpages = disabled;
            html = disabled;
            json = disabled;
          };
        }
      ];
    };
  };
}
