{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      nixos-facter-modules,
      agenix,
      ...
    }@inputs:
    let
    system = "x86_64-linux";
    hosts = [
      { username = "citadel"; hostname = "citadel.quantinium.dev"; stateVersion = "25.11"; config = ./hosts/citadel/configuration.nix; }
    ];
    pkgs = import nixpkgs { inherit system; };
    makeSystem = { username, hostname, stateVersion, config }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs username hostname stateVersion;
      };
      modules = [
        ./hosts/${username}/digitalocean.nix
        disko.nixosModules.disko
        { disko.devices.disk.disk1.device = "/dev/vda"; }
        config
        agenix.nixosModules.default
      ];
    };
    in
    {
      nixosConfigurations = builtins.listToAttrs (map
        (host: {
          name = host.username;
          value = makeSystem {
            inherit (host) username hostname stateVersion config;
          };
        })
        hosts);
    };
}
