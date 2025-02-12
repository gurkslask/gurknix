{ config, pkgs, ... }:

{
  # imports = [
    # <plasma-manager/modules>
  # ];
  # Home Manager needs a bit of information about you and the paths it should
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.sessionPath = [
  	"/home/alex/.nix-profiles/go/bin"
  ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.git.enable = true;
  
  programs.fish.enable = true;
  # programs.plasma = {
    # enable = true;
    #workspace = {
      #clickItemTo = "select";
      #lookAndFeel = "org.kde.breezedark.desktop";
      #cursor = {
        #theme = "Bibata-Modern-Ice";
	#size = 32;
      #};
    #};
    #iconTheme = "Papirus-Dark";
  # };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    extraConfig = ''
    inoremap jj <Esc>
    autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    hi MatchParen cterm=bold,underline ctermbg=none ctermfg=magenta
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set relativenumber
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
      mini-nvim
      go-nvim
    ];
  };
  home.packages = with pkgs; [
    #(nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    mixxx
    spotdl
    ansible
    beekeeper-studio
    steam
    tailscale
    chromium
    spotify
    ventoy
    #ESP-Home
    esphome
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

    # Steam
    # steam

  ];

  #home.file = {
    #".gradle/gradle.properties".text = ''
      #org.gradle.console=verbose
      #org.gradle.daemon.idletimeout=3600000
    #'';
  #};
  programs.git = {
    userEmail = "gurkslask@gmail.com";
    userName = "gurkslask";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GOBIN = "/home/alex/.nix-profile/bin/go";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
