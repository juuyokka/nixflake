{
  fileSystems = {
    "/storage".device = "/dev/mapper/vg1-pool";
    "/nix" = {
      device = "/storage/nix";
      options = [ "bind" ];
    };
  };
}
