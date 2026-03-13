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
      ../modules/nixos/vscodeCSharp.nix
    ];
    

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  #Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  

  networking.hostName = "laptop8"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

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
    autoLogin.user = "admin";
    sddm.wayland.enable = true;
  };
  # Enable automatic login for the user.
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  environment.variables = {
    KWIN_DRM_PREFER_COLOR_DEPTH = "24";
  };

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
    admin = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "ubridge" ];
      initialPassword = "Minne2020";
    };

    elev = {
      isNormalUser = true;
      extraGroups = [ ]; # VIKTIGT: Inte med i 'networkmanager'-gruppen
      initialPassword = "prov";
    };
  };

  # Polkit-regel: Endast användare i 'networkmanager'-gruppen får ändra nätverk
  /* security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 &&
          subject.isInGroup("networkmanager")) {
        return polkit.Result.YES;
      }
      
      // Förbjud allt nätverksrelaterat för alla andra (som 'elev')
      if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0) {
        return polkit.Result.NO;
      }
    });
  ''; */


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.default
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    fira-code-nerdfont
    nerd-fonts.jetbrains-mono
    grc
    displaylink
    calibre
    wget
    minicom
    nfs-utils
    # Remmina
    remmina
    #gns3
    gns3-server
    ubridge
    dynamips
    putty
    vpcs
    gcc
    linode-cli
    libreoffice
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
    # SQLc
    sqlc
    #ESP-Home
    #esphome
    # MQTT
    mqttui
    go
    python3
    pyright
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
    lshw


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
  networking.firewall = rec {
    allowedTCPPorts = [80 22];
    allowedUDPPorts = [22];
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  
  programs.git = {
     enable = true;
  };

 
}
