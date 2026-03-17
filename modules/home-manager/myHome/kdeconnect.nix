{ config, lib,  ... }:

let
  cfg = config.myHome.kdeconnect;
in
{
  options.myHome.kdeconnect = with lib; {
    enable = mkEnableOption "kdeconnect";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "${config.home.profileDirectory}/bin/nvim";
    };
    services.kdeconnect = lib.mkMerge [{
      enable = true;
    }] ;
  };
}

