{config, ...}:{
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    extraCommands = ''
      iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set
      iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j REJECT --reject-with tcp-reset
    '';
  };
}
