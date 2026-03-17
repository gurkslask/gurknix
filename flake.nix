{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, ... }: 

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
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    darwinConfigurations."alex" = nix-darwin.lib.darwinSystem {
      # Alexs-Macbook = nixpkgs.lib.nixosSystem {
      # specialArgs = {inherit inputs ;};
      modules = [
        # > Our main nixos configuration file <
	configuration
        ./mac/configuration.nix
        inputs.home-manager.nixosModules.home-manager  {
	  nixpkgs = nixpkgsConfig;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # extraSpecialArgs skickar 'inputs' till dina home_alex.nix-filer
          # home-manager.extraSpecialArgs = { inherit inputs; };
          # Här kopplar vi dina användare till deras HM-filer
          home-manager.users.alex = import ./home-manager/home_alex_darwin.nix;
        }
      ];
    };
    nixosConfigurations = {
      jenna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs ;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos_T490/configuration.nix
        home-manager.nixosModules.home-manager  {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # extraSpecialArgs skickar 'inputs' till dina home_alex.nix-filer
          home-manager.extraSpecialArgs = { inherit inputs; };

          # Här kopplar vi dina användare till deras HM-filer
          home-manager.users.alex = import ./home-manager/home_alex.nix;
        }
        ];
      };
      frejnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs ;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos_T490/configuration.nix
        home-manager.nixosModules.home-manager  {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # extraSpecialArgs skickar 'inputs' till dina home_alex.nix-filer
          home-manager.extraSpecialArgs = { inherit inputs; };

          # Här kopplar vi dina användare till deras HM-filer
          home-manager.users.alex = import ./home-manager/home_alex.nix;
        }
        ];
      };
      laptop8 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs ;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos_l8/configuration.nix
        home-manager.nixosModules.home-manager  {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
          
          # extraSpecialArgs skickar 'inputs' till dina home_alex.nix-filer
          home-manager.extraSpecialArgs = { inherit inputs; };

          # Här kopplar vi dina användare till deras HM-filer
          home-manager.users.admin = import ./home-manager/home_admin.nix;
          home-manager.users.elev = import ./home-manager/home_elev.nix;
        }
        ];
      };
    };
  };
}
