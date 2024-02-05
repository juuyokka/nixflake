{
  disko.devices = {
    disk = {
      boot = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT1000T700SSD3_2339E87A058B";
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
		            mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              type = "8E00";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "vgroot";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      vgroot = {
        type = "lvm_vg";
        lvs = {
          rootfs = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
