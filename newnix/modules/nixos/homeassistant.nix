{ config, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "met"       # Väderprognos (exempel)
      "esphome"   # Integrationen för att prata med enheterna
    ];
    config = {
      # Grundläggande konfiguration
      default_config = {};
      http = {
        server_port = 8123;
        trusted_proxies = [ "127.0.0.1" "::1" ];
      };
    };
  };

  # Öppna porten i brandväggen
  networking.firewall.allowedTCPPorts = [ 8123 ];
}
