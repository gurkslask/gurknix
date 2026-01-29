{ config, lib,  ... }:

let
  cfg = config.services.myfrigate;
in
{
  options.services.myfrigate = with lib; {
    enable = mkEnableOption "frigate";

    hostname = lib.mkOption {
      type = lib.types.str;
      default = "localhost"; 
    };
  };

  config = lib.mkIf cfg.enable {
    services.frigate = {
      hostname = cfg.hostname;
    };
  };
  
}

