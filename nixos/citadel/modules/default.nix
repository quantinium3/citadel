{
  imports = [
    ./grub.nix
    ./networking.nix
    ./nginx.nix
    ./packages.nix
    ./user.nix
    ./tailscale.nix
    ./virtualization.nix
    ./http-echo.nix
    ./uptime-kuma.nix
  ];
}
