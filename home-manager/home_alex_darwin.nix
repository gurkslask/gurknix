{ config, pkgs, ... }:

{
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
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
  home.file = {
    #"$home.homeDirectory" = {
    "nvim" = {
      # source = config.lib.file.mkOutOfStoreSymlink ../dotfiles/nvim;
      source = config.lib.file.mkOutOfStoreSymlink /home/alex/Projects/gurknix/newnix/dotfiles/nvim/lua;
      #source = ../dotfiles;
      recursive = false;
      force = true;
      target = "./.config/nvim/lua";
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
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    htop
  ];

}
