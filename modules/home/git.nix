{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.milky.git;
in
{
  options.milky.git = {
    enable = mkEnableOption "Git";
  };

  config = mkIf cfg.enable {
    programs.lazygit.enable = true;
    programs.git = rec {
      enable = true;

      aliases = {
        oops = "reset --soft HEAD~1";
        trash = "reset --hard HEAD";
      };

      userName = "lactose";
      userEmail = "juuyokka@users.noreply.github.com";

      # TODO: this needs some logic to allow custom directories or fail an assert with a
      # "you can set the homeDir" option in the wrapper attributes.
      signing.key = config.home.homeDirectory + "/.ssh/id_ed25519";
      signing.signByDefault = true;

      extraConfig = {
        gpg.format = "ssh";
        pull.rebase = false;
      };
    };
  };
}
