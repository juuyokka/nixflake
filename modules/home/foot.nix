{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.milky.foot;
in
{
  options.milky.foot = {
    enable = mkEnableOption "Enable foot";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMonoNL NFM:size=14";
          font-italic = "VictorMono NFM Bold Italic:12";
          font-bold-italic = "VictorMono NFM Bold Italic:12";
        };
      };
    };
  };
}
