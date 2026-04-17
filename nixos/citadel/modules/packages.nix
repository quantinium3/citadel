{ pkgs, lib, ... }: {
  environment.systemPackages = map lib.lowPrio [
    pkgs.wget
    pkgs.openssl
    pkgs.curl
    pkgs.btop

    pkgs.fastfetch

    pkgs.gitMinimal

		pkgs.lsd

		pkgs.mosh

    pkgs.helix
  ];
}
