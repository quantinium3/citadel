SSH_OPTS    = -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new

.PHONY: switch generate-hardware-config

help:
	@echo "NixOS Remote Deployment Commands:"
	@echo "  make switch         - Rebuild and switch (permanent)"
	@echo "  make generate-hardware-config         - Generate Hardware configuration (permanent)

switch:
	nixos-rebuild switch --flake .#citadel --target-host root@citadel.talpidae-fiordland.ts.net

generate-hardware-config:
	nix --extra-experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- \
		--flake '.#citadel' \
		--generate-hardware-config nixos-generate-config ./hosts/citadel/hardware-configuration.nix \
		citadel