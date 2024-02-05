{
  disko.devices = {
    disk = {
			boot = {
				type = "disk";
				device = "/dev/disk/by-id/nvme-CT1000T700SSD3_2339E87A058B";
				content {
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
							type = "8E00";
							size = "100%";
							content = {
								type = "lvm_pv";
								vg = "root";
							};
						};
					};
				};
			};
    };
		lvm_vg = {
			root = {
				type = "lvm_vg";
				lvs = {
					root = {
						type = "8300";
						size = "100%";
						content = {
							type = "filesystem";
							format = "/";
						};
					};
				};
			};
		};
  };
}
