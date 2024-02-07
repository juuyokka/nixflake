{
  imports = [
    ../../roles/workstation.nix
    ./hardware.nix
    ./disko.nix
  ];

  networking.hostName = "milk-jug";

  milky.hm.extraHomeConfig = {
    wayland.windowManager.hyprland.settings = {
      monitor = [ "DP-1,2560x1440@170,0x0,1.25" ];
    };
  };

  boot.initrd.services.lvm.enable = true;
  services.lvm.boot.thin.enable = true;

  environment.etc."wireplumber/51-disable-webcam-mic.lua".source =
    ./51-disable-webcam-mic.lua;
}
