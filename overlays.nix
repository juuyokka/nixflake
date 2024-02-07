{ inputs, pkgs, self, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-milky = final: prev: {
    milky = self.packages.${system};
  };
in
{
  nixpkgs.overlays = [
    overlay-milky
  ];
}
