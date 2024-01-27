# run disko
disko path:
	sudo disko --mode disko {{path}}

# format using alejandra
format:
	alejandra .

# install NixOS
install host:
	sudo nixos-install --flake .#{{host}}
