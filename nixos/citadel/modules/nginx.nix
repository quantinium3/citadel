{
	services.nginx = {
		enable = true;
	};
  systemd.tmpfiles.rules = [
    "d /var/log/nginx 0750 nginx nginx -"
  ];
}
