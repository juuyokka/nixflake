{ config
, lib
, inputs
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.milky.hyprland;
in
{
  options.milky.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
    system = mkOption {
      type = types.str;
      default = "x86_64-linux";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      package = inputs.hyprland.packages.${cfg.system}.default;
      plugins = [ inputs.hy3.packages.${cfg.system}.default ];
      xwayland.enable = true;
      enable = true;

      # TODO: do some cool stuff here!
      settings = { };
    };
  };
}
