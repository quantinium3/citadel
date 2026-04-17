let
  fedora = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZ0Vf2P78j+5yVFoOw/sNQO4II00k00fbse09zhWUab";
  citadel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINyGOWyN5+YD815B3eEkKqVA3BLuEp2sIn3QUJNWxXFO";
in
{
  "password.age".publicKeys = [ fedora citadel ];
  "tailscale_auth_key.age".publicKeys = [ fedora citadel ];
}
