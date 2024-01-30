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

  cfg = config.milky.firefox;
in
{
  options.milky.firefox = {
    enable = mkEnableOption "Enable Firefox";
    bookmarks = mkOption {
      type = with types; listOf attrs;
      default = [ ];
      # some bs
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.milky = {
        inherit (cfg) bookmarks;
      };
    };
  };
}
