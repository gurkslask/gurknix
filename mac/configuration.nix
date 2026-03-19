# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{  config, pkgs, inputs, ...  }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
      # ./main-user.nix
      # inputs.home-manager.nixosModules.default
      # ../modules/nixos/borg.nix
      # ../modules/nixos/frigate.nix
      # ../modules/nixos/tailscale.nix
      # ../modules/nixos/users.nix
      ../modules/nixos/brew.nix
    ];
    
  # networking.hostName = "jenna"; # Define your hostname.

  users.users.alex = {
    home = "/Users/alex";
    shell = pkgs.fish;
  };

  home-manager.users.alex = {
    # KRITISKT: Detta tvingar HM att använda rätt stig oavsett sudo
    home.username = "alex";
    home.homeDirectory = "/Users/alex";
  };

  system.primaryUser = "alex";
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [ 
    tree-sitter
    vim
    git
    fish
    neovim
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    linode-cli
    sshpass
    spotdl
    ansible
    tmux
    # steam
    go
    hugo
    fastfetch
    nnn # terminal file manager
    gotools
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    nix-output-monitor
    nix-search-cli
  ];
  
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;
  
  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;
  
  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Docker
  # virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;


}
