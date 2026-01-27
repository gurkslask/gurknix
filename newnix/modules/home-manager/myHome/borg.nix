{ config, lib,  ... }:

let
  cfg = config.myHome.borg;
in
{
  options.myHome.kdeconnect = with lib; {
    enable = mkEnableOption "borg";
  };

  config = lib.mkIf cfg.enable {
    services.borgbackup.jobs.home-alex = {
      paths = "/home/alex";
      encryption.mode = "none";
      environment.BORG_RSH = "ssh -i /home/alex/.ssh/id_rsa";
      repo = "ssh://kagg@kagg-server:/mnt/vg0-filer/backup";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
  
}

