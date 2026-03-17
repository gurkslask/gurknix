{
  description = "Your new nix config";

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
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    darwinConfigurations."alex" = nix-darwin.lib.darwinSystem {
      # Alexs-Macbook = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs ;};
      modules = [
        # > Our main nixos configuration file <
	configuration
        ./mac/configuration.nix
        inputs.home-manager.darwinModules.home-manager  {
	  nixpkgs = nixpkgsConfig;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
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
