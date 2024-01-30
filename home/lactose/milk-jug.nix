{ pkgs, ... }: {
  home = rec {
    username = "lactose";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  milky = {
    foot.enable = true;
    git.enable = true;
    hyprland.enable = true;
    neovim.enable = true;
    vesktop.enable = true;

    firefox.enable = true;
    firefox.bookmarks = [
      {
        name = "NixOS";
        toolbar = true;
        bookmarks = [
          {
            name = "NixOS Packages";
            url = "https://search.nixos.org/packages";
          }
          {
            name = "NixOS Options";
            url = "https://search.nixos.org/options";
          }
          {
            name = "NixOS Wiki";
            url = "https://nixos.wiki";
          }
        ];
      }
    ];

  };
}
