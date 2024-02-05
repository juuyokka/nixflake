{ config, lib, inputs, self, ... }:
let
  inherit (lib)
		mkEnableOption
		mkIf
		mkOption
		types
		;

		cfg = config.milky.hyprland-portals;
in
{
	option.milky.hyprland-portals = {
		enable = mkEnableOption "Enable xdg-desktop-portals for Hyprland";
		system = mkOption {
      type = types.str;
      default = "x86_64-linux";
    };
	};

	config = mkIf cfg.enable rec {
		xdg.portal = {
			enable = true;
			extraPortals = with pkgs; [
					inputs.hyprland.inputs.xdph.packages.${cfg.system}.default
					xdg-desktop-portal-gtk
			];
		};
	};
}
