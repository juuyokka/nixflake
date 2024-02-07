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
    mod
    range
    types
    zipLists
    ;
  inherit (builtins)
    attrValues
    concatLists
    listToAttrs
    mapAttrs
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
    extraConfig = mkOption {
      type = types.lines;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      package = inputs.hyprland.packages.${cfg.system}.default;
      plugins = [ inputs.hy3.packages.${cfg.system}.default ];
      xwayland.enable = true;
      enable = true;
      inherit (cfg) extraConfig;

      settings =
        let
          md = cfg.modKey;
          # This function takes an attrset of mappings (e.g. keys to workspaces)
          # and functions that use each mapping to create a list of binds
          mapBind = (bindMap: binds:
            concatLists (attrValues (mapAttrs
              (x: y:
                (map
                  (b: b x y)
                  (attrValues binds)))
              bindMap)));

          workspaceBindings =
            let
              bindMap = (listToAttrs (map
                (n: { name = "${toString (mod n 10)}"; value = "${toString n}"; })
                (range 1 10)));

              binds = {
                switch = x: y: "${md},${x},workspace,${y}";
                move = x: y: "${md}+CTRL,${x},movetoworkspacesilent,${y}";
                moveswitch = x: y: "${md}+SHIFT,${x},movetoworkspace,${y}";
              };
            in
            mapBind bindMap binds;

          windowBindings =
            let
              bindMap = {
                "H" = "l";
                "J" = "d";
                "K" = "u";
                "L" = "r";
              };

              binds = {
                focus = x: y: "${md},${x},movefocus,${y}";
              };
            in
            mapBind bindMap binds;
        in
        {
          bind = [
            "${md},RETURN,exec,foot"
            "${md}+SHIFT,Q,killactive"
            "${md},C,exec,vencorddesktop"
            "${md},W,exec,firefox"
            "${md}+SHIFT,E,exit"

            "${md},F,fullscreen"
            "${md}+CTRL,F,fakefullscreen"
          ]
          ++ windowBindings
          ++ workspaceBindings
          ;

          general = {
            layout = "master";
          };

          env = [
            "NIXOS_OZONE_WL,1"
            "GDK_SCALE,1.25"
            "QT_SCALE_FACTOR,1.25"
            "ELM_SCALE,1.25"
          ];
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            force_default_wallpaper = 0;
            enable_swallow = true;
            swallow_regex = "^foot(client)?$";
          };

          xwayland = {
            force_zero_scaling = true;
          };
        };
    };
  };
}
