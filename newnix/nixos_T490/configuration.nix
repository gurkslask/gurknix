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
      inputs.home-manager.nixosModules.default
    ];
    

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  
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

  networking.hostName = "nixos"; # Define your hostname.
  services.tailscale.enable = true;
  services.mullvad-vpn.enable = true;
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
  services.libinput.enable = true;
  # Disable touchpad while typing
  services.libinput.touchpad.disableWhileTyping = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alex";
  services.desktopManager.plasma6.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
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


  programs.fish.enable = true;
  
  users.groups.ubridge = {};

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    alex = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "ubridge" "docker" ];
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
    };
  };


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
  "beekeeper-studio-5.1.5"
  "ventoy-1.1.05"
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    calibre
    wget
    #gns3
    gns3-server
    ubridge
    dynamips
    putty
    vpcs
    gcc
    linode-cli
    # File manager
    # dolphin
    # Network manager
    # networkmanagerapplet
    # tlp
    tlp
    # Bluetooth
    # blueman
    gimp
    sshpass
    mixxx
    spotdl
    ansible
    tmux
    steam
    tailscale
    chromium
    spotify
    ventoy
    # SQLc
    sqlc
    #ESP-Home
    #esphome
    # MQTT
    mqttui
    go
    python3
    hugo
    vscodium
    neofetch
    nnn # terminal file manager
    gotools

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

  ];
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
   networking.firewall.allowedTCPPorts = [80 22];
   networking.firewall.allowedUDPPorts = [22];
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
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 60; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 85; # 80 and above it stops charging

      };
  };
 
}
