{ config, pkgs, lib, ... }:

{
  # Reach at localhost:6052
  services.esphome = {
    enable = true;
    address = "0.0.0.0";
    port = 6052;
  };


  systemd.services.esphome.serviceConfig = {
    # Kör tjänsten som din användare
    User = lib.mkForce "alex";
    Group = lib.mkForce "users";
    
    # Peka om alla arbetsfiler till din hemmapp
    # Vi skapar en mapp som heter .esphome_data
    Environment = ["HOME=/home/alex" "PLATFORMIO_CORE_DIR=/home/alex/.esphome/.platformio" ];

    WorkingDirectory = lib.mkForce "/home/alex";
    
    # Vi stänger av sandlådan så den får skriva i din hemmapp
    ProtectHome = lib.mkForce false;
    ReadWritePaths = [ "/home/alex" ];
  };

  # Öppna porten för webbgränssnittet
  networking.firewall.allowedTCPPorts = [ 6052 ];

  # Tillåt din användare att kommunicera med USB-enheter (för flashing)
  users.users.alex.extraGroups = [ "dialout" ];

  # Lägg till användare i gruppen dialout
  users.groups.dialout.members = [ "alex" "esphome"];
}
