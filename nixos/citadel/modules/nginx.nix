{ ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    commonHttpConfig = ''
      http2 on;
      ssl_early_data on;
    '';

    virtualHosts."citadel.quantinium.dev" = {
      sslCertificate = "/etc/nginx/certificates/citadel.quantinium.dev.pem";
      sslCertificateKey = "/etc/nginx/certificates/citadel.quantinium.dev.key";
      forceSSL = true;
      http3 = true;
      quic = true;

      locations = {
        "/" = {
          proxyPass = "http://127.0.0.1:5678";
          extraConfig = ''
            add_header Alt-Svc 'h3=":443"; ma=86400' always;
          '';
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/log/nginx 0750 nginx nginx -"
  ];
}
