{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.milky.neovim;
in
{
  options.milky.neovim = {
    enable = mkEnableOption "Enable Neovim";
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;
  };
}
