# run disko
disko path:
	sudo disko --mode disko {{path}}

# format using nixpkgs-fmt
format:
	nixpkgs-fmt .

# install NixOS
install host:
	sudo nixos-install --flake .#{{host}}
