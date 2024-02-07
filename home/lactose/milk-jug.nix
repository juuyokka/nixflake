{ pkgs, ... }: {
  home = rec {
    username = "lactose";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };


  milky = {
    cursor = {
      enable = true;
      package = pkgs.milky.xcursor-pro;
      theme = "XCursor-Pro-Dark";
      size = 32;
    };

    foot.enable = true;
    git.enable = true;
    hyprland.enable = true;
    neovim.enable = true;
    vesktop.enable = true;
    zsh.enable = true;

    firefox.enable = true;
    firefox.bookmarks = [
      {
        name = "NixOS";
        toolbar = true;
        bookmarks = [
          {
            name = "NixOS Config";
            url = "https://github.com/juuyokka/nixflake";
          }
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
