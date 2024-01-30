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
    range
    types
    zipLists
    ;
  inherit (builtins)
    toString
    ;

  cfg = config.milky.hyprland;
in
{
  options.milky.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
    modKey = mkOption {
      type = types.str;
      default = "SUPER";
    };
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

      settings =
        let
          mod = cfg.modKey;
          workspaceBindings =
            let
              fn = x: "${mod},${toString x.fst},workspace,${toString x.snd}";
              rn = range 1 9;
              ls = (zipLists rn rn) ++ [{ fst = 0; snd = 10; }];
            in
            map fn ls;
        in
        {
          bind = [
            "${mod},KP_Enter,exec,foot"
            "${mod}+SHIFT,Q,killactive"
            "${mod},C,exec,vencorddesktop"

            "${mod},H,movefocus,l"
            "${mod},J,movefocus,d"
            "${mod},K,movefocus,u"
            "${mod},L,movefocus,r"
          ] ++ workspaceBindings;

          general = {
            layout = "master";
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            force_default_wallpaper = 0;
            enable_swallow = true;
            swallow_regex = "^foot(client)?$";
          };
        };
    };
  };
}
