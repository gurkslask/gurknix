{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    nixpkgsConfig = {
      config.allowUnfree = true;
    };
    configuration = { pkgs, ... }: {

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."alex" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ./configuration.nix
        inputs.home-manager.darwinModules.home-manager
        {
          nixpkgs = nixpkgsConfig;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.alex = import ../home-manager/home_alex_darwin.nix;

        }
      ];

    };
  };
}
