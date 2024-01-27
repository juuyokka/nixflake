{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-Sabrent_SB-ROCKET-NVMe4-1TB_48790459505232";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              type = "8300";
              size = "160G";
              content = {
                type = "filesystem";
                format = "xfs";
                extraArgs = [ "-f" ];
                mountpoint = "/";
              };
            };
            nix = {
              type = "8300";
              size = "128G";
              content = {
                type = "filesystem";
                format = "btrfs";
                extraArgs = [ "-f" ];
                mountOptions = [ "compress=zstd:15" "nodatacow" ];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
  };
}
