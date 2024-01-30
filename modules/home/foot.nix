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
          font = "JetBrainsMonoNL NFM Regular:20";
          font-italic = "VictorMono NFM Bold Italic:17";
          font-bold-italic = "VictorMono NFM Bold Italic:17";
        };
      };
    };
  };
}
