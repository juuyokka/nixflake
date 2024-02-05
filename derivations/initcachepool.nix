{ writeShellApplication, libxfs, lvm2, parted }:
{ storageDisk, cacheDisk }:
writeShellApplication {
  name = "initcachepool";
  runtimeInputs = [ libxfs lvm2 parted ];

  text = ''
    		init_part() {
    			local disk=$1
    			parted -s "$disk" mklabel gpt
    			parted -s "$disk" mkpart lvm 0% 100%

    			local part
    			part=$(lsblk -no PATH "$disk" | tail -n1)
    			pvcreate "$part" > /dev/null
    			echo "$part"
    		}

    		storagePV=$(init_part ${storageDisk})
    		cachePV=$(init_part ${cacheDisk})

    		vgcreate vgstorage "$storagePV" "$cachePV"

    		lvcreate -l 100%FREE -n cachevol vgstorage "$cachePV"
    		lvcreate -l 100%FREE -n pool vgstorage "$storagePV"

    		lvconvert --type cache -c2M --cachevol cachevol vgstorage/pool

    		mkfs.xfs -f /dev/vgstorage/pool

    		mkdir -p /mnt/storage

    		mount /dev/vgstorage/pool /mnt/storage

    		mkdir -p /mnt/storage/nix /mnt/nix
    	'';
}
