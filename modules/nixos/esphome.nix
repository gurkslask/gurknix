{ config, lib, pkgs, ... }:

let
  cfg = config.services.myesphome;
  # Vi inkluderar build-fhs-userenv för att tillåta esphome att köra 
  # nedladdade binärer som annars kraschar på NixOS.
in {
  options.services.myesphome = {
    enable = lib.mkEnableOption "ESPHome Dashboard";
    address = lib.mkOption { type = lib.types.str; default = "0.0.0.0"; };
    port = lib.mkOption { type = lib.types.port; default = 6052; };
    configDir = lib.mkOption { 
      type = lib.types.str; 
      default = "/var/lib/esphome"; 
    };
  };

  config = lib.mkIf cfg.enable {
    # 1. Skapa användaren explicit med fasta rättigheter
    users.users.esphome = {
      isSystemUser = true;
      group = "esphome";
      extraGroups = [ "dialout" "tty" ]; 
      home = cfg.configDir;
      createHome = true;
    };
    users.groups.esphome = {};

    # 2. Fixa rättigheter för mappen innan start
    systemd.tmpfiles.rules = [
      "d ${cfg.configDir} 0755 esphome esphome -"
    ];

    systemd.services.esphome = {
      description = "ESPHome Dashboard Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      path = with pkgs; [
        esphome
        platformio
        git
        openssh
        inetutils # För ping/u2f-checkar
        python3
      ];

      serviceConfig = {
        User = "esphome";
        Group = "esphome";
        WorkingDirectory = cfg.configDir;
        
        # Säkerställ att ESPHome har en skrivbar TEMP-mapp
        RuntimeDirectory = "esphome";
        StateDirectory = "esphome";
        
        # Denna rad är kritisk: Den tillåter ESPHome att skriva i sin hemkatalog
        ReadWritePaths = [ cfg.configDir ];

        # Startkommando
        ExecStart = "${pkgs.esphome}/bin/esphome dashboard --address ${cfg.address} --port ${toString cfg.port} ${cfg.configDir}";
        
        Restart = "on-failure";
      };

      # Miljövariabel för att hjälpa PlatformIO att hitta rätt i NixOS
      environment = {
        PLATFORMIO_CORE_DIR = "${cfg.configDir}/.platformio";
        ESPHOME_DATA_DIR = "${cfg.configDir}/.data";
      };
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
