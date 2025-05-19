{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    packages.x86_64-linux.neovim-custom = pkgs.neovim.withPlugins (p: with p; [
      nvim-tree.plugin
      # Lägg till fler plugins här
      # telescope-nvim.plugin
      # nvim-lspconfig
    ]);

    # Om du vill ha en binär som kan köras direkt (ej rekommenderat för Home Manager)
    # apps.x86_64-linux.neovim-with-plugins = {
    #   type = "app";
    #   program = "${self.packages.x86_64-linux.neovim-custom}/bin/nvim";
    # };
  };
}
