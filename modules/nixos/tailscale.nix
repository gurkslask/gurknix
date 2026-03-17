{ config, pkgs, ... }:

{
  # Aktiverar Tailscale-tjänsten
  services.tailscale.enable = true;

  # Öppna porten som Tailscale använder för att kommunicera (UDP 41641)
  # Detta hjälper till att få en direktanslutning istället för via relä (DERP)
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # Se till att Tailscale startar och försöker ansluta direkt vid boot
  systemd.services.tailscale = {
    after = [ "network-pre.target" "tailscaled.service" ];
    wants = [ "network-pre.target" "tailscaled.service" ];
    wantedBy = [ "multi-user.target" ];
  };
}
