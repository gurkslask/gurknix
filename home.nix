{ config, pkgs, ... }:

{
  imports = [
    # <plasma-manager/modules>
    # outputs.homeManagerModules.myHome.neovim

  ];
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
      typescript-tools-nvim
      # nerdtree
      neo-tree-nvim

    ];
  };
  home.packages = with pkgs; [
    #(nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
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
