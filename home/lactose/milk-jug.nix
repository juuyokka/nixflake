{pkgs, ...}: {
  home = rec {
    username = "lactose";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
}
