{ ... }:
{
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;
    extraConfig = ''
      server=/consul/127.0.0.1#8600
      interface=lo
      bind-interfaces
    '';
  };
}
