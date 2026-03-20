# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  config,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ../modules/home-manager/myHome/nvim.nix
    ../modules/home-manager/myHome/kdeconnect.nix
    ../modules/home-manager/myHome/shell.nix

    
  ];
  myHome = {
    kdeconnect = {
      enable = true;
    };
    neovim = {
      enable = true;
      enableLSP = true;
      #enabbdsa = true;
    };
  };

  nixpkgs = {
    # You can add overlays here
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };
  #home.file."${config.xdg.configHome}" = {
  /*home.file = {
    #"$home.homeDirectory" = {
    "nvim" = {
      # source = config.lib.file.mkOutOfStoreSymlink ../dotfiles/nvim;
      source = config.lib.file.mkOutOfStoreSymlink /home/alex/Projects/gurknix/newnix/dotfiles/nvim/lua;
      #source = ../dotfiles;
      recursive = false;
      force = true;
      target = "./.config/nvim/lua";
    };
  };*/
  # TODO: Set your username
  home = {
    username = "elev";
    homeDirectory = "/home/elev";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  # programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Alexander Svensson";
    userEmail = "gurkslask@gmail.com";
    aliases = {
      gs = "status";
      co = "checkout";
      gc = "commit";
      glog = "log --oneline --graph --decorate --all";
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting ""
    '';
    shellAliases = {
      v = "nvim";
      ls = "eza --icons";
      nrs = "sudo nixos-rebuild switch";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
