{ config, pkgs, ... }:

{
  # Reach at localhost:8123
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
      };
    };
  };

  # Öppna porten i brandväggen
  networking.firewall.allowedTCPPorts = [ 8123 ];
}
