# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, inputs, ...  }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
      # ./main-user.nix
      # inputs.home-manager.nixosModules.default
      # ../modules/nixos/borg.nix
      # ../modules/nixos/frigate.nix
      # ../modules/nixos/tailscale.nix
      ../modules/nixos/users.nix
      ../modules/nixos/brew.nix
    ];
    

  


  # networking.hostName = "jenna"; # Define your hostname.

  # Docker
  # virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";


  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure console keymap
  console.keyMap = "sv-latin1";

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.fish.enable = true;
  

  # Install firefox.
  programs.firefox.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = rec {
    allowedTCPPorts = [80 22];
    allowedUDPPorts = [22];
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
};

  programs.git = {
     enable = true;
     # userName = "Alexander Svensson";
     # userEmail = "gurkslask@gmail.com";
  };
 
}
