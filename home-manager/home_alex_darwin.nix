{ config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager/myHome/nvim.nix
    ../modules/home-manager/myHome/shell.nix
  ];
  myHome = {
    neovim = {
      enable = true;
      enableLSP = true;
      #enabbdsa = true;
    };
  };
  home= {
    username = "alex";
    homeDirectory = "/Users/alex";
    #"$home.homeDirectory" = {
    file = {
      "nvim" = {
        # source = config.lib.file.mkOutOfStoreSymlink ../dotfiles/nvim;
        source = config.lib.file.mkOutOfStoreSymlink ../dotfiles/nvim/lua;
        #source = ../dotfiles;
        recursive = false;
        target = "./.config/nvim/lua/";
      };
    };
  };
    
# Detta injicerar variablerna i ditt skal (zsh/bash)
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
  programs.git = {
    enable = true;
    settings = {
      user.name = "alexander svensson";
      user.email = "gurkslask@gmail.com";
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    htop
  ];

}
