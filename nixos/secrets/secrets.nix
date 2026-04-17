let
  fedora = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHBIU3AnHDRuCe0wSD79jokW6PLaUnw35OrLc4F3dEs";
  citadel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxZm0uiNMIk2dGURnAyjcyX7UiY1UuClfsHvlDA4Wzo";
in
{
  "password.age".publicKeys = [
    fedora
    citadel
  ];
  "tailscale_auth_key.age".publicKeys = [
    fedora
    citadel
  ];
  "postgres_user.age".publicKeys = [
    fedora
    citadel
  ];
  "postgres_password.age".publicKeys = [
    fedora
    citadel
  ];
  "postgres_database.age".publicKeys = [
    fedora
    citadel
  ];
}
