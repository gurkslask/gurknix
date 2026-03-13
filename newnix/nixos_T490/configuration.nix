# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# --- Install Home manager
#sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
#sudo nix-channel --update

{ config, pkgs, inputs, ...  }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./main-user.nix
      # inputs.home-manager.nixosModules.default
      ../modules/nixos/borg.nix
      ../modules/nixos/frigate.nix
      ../modules/nixos/tailscale.nix
      ../modules/nixos/users.nix
    ];
    

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Borg
  services.myborg = {
    enable = true;
    repoPath = "ssh://kagg@kagg-server/mnt/vg0-filer/backup"; 
  };

  # Frigate
  services.myfrigate = {
    enable = false;
  };
  
  #Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  networking.hostName = "jenna"; # Define your hostname.
  # services.mullvad-vpn.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Docker
  virtualisation.docker.enable = true;


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # uBridge gns 3
  security.wrappers.ubridge = {
    source = "/run/current-system/sw/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+x";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
  };
  # Disable touchpad while typing
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
    autoLogin.enable = true;
    sddm.enable = true;
    autoLogin.user = "alex";
    sddm.wayland.enable = true;
  };
  # Enable automatic login for the user.
  services.desktopManager.plasma6.enable = true;
  # services.desktopManager.defaultSession = "plasma";
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  environment.variables = {
    KWIN_DRM_PREFER_COLOR_DEPTH = "24";
  };
  # programs.hyprland = {
    # enable = true;
    # xwayland.enable = true;
  # };


  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true; Removed
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
   # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.fish.enable = true;
  
  users.groups.ubridge = {};

  users.users = {
    alex = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "ubridge" "docker" ];
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
    };
  };


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
    "ventoy-1.1.05"
    "frigate-web-0.15.2"
    "frigate-0.15.2"
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  /*environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
  ];*/
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  
  programs.git = {
     enable = true;
     # userName = "Alexander Svensson";
     # userEmail = "gurkslask@gmail.com";
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput = {
    # enable = true;
    # touchpad = {
      # disableWhileTyping = true;
    # };
  # };

  services.power-profiles-daemon.enable = false;
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 75;

       #Optional helps save long term battery health
      # START_CHARGE_THRESH_BAT0 = 60; # 40 and below it starts to charge
      # STOP_CHARGE_THRESH_BAT0 = 90; # 80 and above it stops charging

      };
  };
  systemd.services.displaylink-server = {
    enable = true;
    # Ensure it starts after udev has done its work
    requires = [ "systemd-udevd.service" ];
    after = [ "systemd-udevd.service" ];
    wantedBy = [ "multi-user.target" ]; # Start at boot
    # *** THIS IS THE CRITICAL 'serviceConfig' BLOCK ***
    serviceConfig = {
      Type = "simple"; # Or "forking" if it forks (simple is common for daemons)
      # The ExecStart path points to the DisplayLinkManager binary provided by the package
      ExecStart = "${pkgs.displaylink}/bin/DisplayLinkManager";
      # User and Group to run the service as (root is common for this type of daemon)
      User = "root";
      Group = "root";
      # Environment variables that the service itself might need
      Environment = [ "DISPLAY=:0" ]; # Might be needed in some cases, but generally not for this
      Restart = "on-failure";
      RestartSec = 5; # Wait 5 seconds before restarting
    };
  };
 
}
