{pkgs, ...}: {
  home = rec {
    username = "lactose";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  milky.hyprland.enable = true;
}
