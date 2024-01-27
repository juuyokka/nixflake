{
  imports = [
    ../../roles/workstation.nix
    ./hardware.nix
    ./disko.nix
    ./storage.nix
  ];

  networking.hostName = "milk-jug";

  environment.etc."wireplumber/51-disable-webcam-mic.lua".source =
    ./51-disable-webcam-mic.lua;
}
