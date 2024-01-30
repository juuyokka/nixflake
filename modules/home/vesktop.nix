{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.milky.vesktop;
in
{
  options.milky.vesktop = {
    enable = mkEnableOption "Enable Vesktop";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vesktop ];
  };
}
