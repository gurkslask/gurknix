{ config, pkgs, ... }:

{
  services.esphome = {
    enable = true;
    address = "0.0.0.0";
    port = 6052;
  };

  # Öppna porten för webbgränssnittet
  networking.firewall.allowedTCPPorts = [ 6052 ];

  # Tillåt din användare att kommunicera med USB-enheter (för flashing)
  users.users.alex.extraGroups = [ "dialout" ];
}
