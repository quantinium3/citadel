{config , ... }:
{
  age.secrets.password.file = ./../../secrets/password.age;

  users = {
		mutableUsers = false;
    users = {
			castellan = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker"];
        hashedPasswordFile = config.age.secrets.password.path;
        createHome = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHBIU3AnHDRuCe0wSD79jokW6PLaUnw35OrLc4F3dEs"
        ];
      };

      root = {
      	openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHBIU3AnHDRuCe0wSD79jokW6PLaUnw35OrLc4F3dEs"
        ];
      };
    };
  };
}
