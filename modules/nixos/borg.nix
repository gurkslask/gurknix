{ config, pkgs, lib,  ... }:

let
  cfg = config.services.myborg;
in
{
  options.services.myborg = with lib; {
    enable = mkEnableOption "borg";

    repoPath = lib.mkOption {
      type = lib.types.str;
      default = "ssh://kagg@kagg-server/mnt/vg0-filer/backup"; 
    };
  };

  config = lib.mkIf cfg.enable {
    services.borgbackup.jobs.home-alex = {
      paths = "/home/alex";
      encryption.mode = "none";
      environment.BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /home/alex/.ssh/id_rsa";
      repo = cfg.repoPath;
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
  
}

