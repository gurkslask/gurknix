{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
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
      /* -----
        Här kommer koden för att skapa 19 stycken laptops
        ------ */
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib;
  # En hjälpfunktion för att skapa en laptop-konfiguration
  mkLaptop = hostname: nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs hostname; }; # Vi skickar med hostname som ett argument!
    modules = [
      ./nixos_l8/configuration.nix # Samma bas-konfiguration för alla
      
      # Dynamiskt sätt hostname baserat på namnet vi skickar in
      { networking.hostName = hostname; }

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.admin = import ./home-manager/home_admin.nix;
        home-manager.users.elev = import ./home-manager/home_elev.nix;
      }
    ];
  };
  in {
    # Generera laptop1 till laptop19
    nixosConfigurations = builtins.listToAttrs (map (n: {
      name = "laptop${toString n}";
      value = mkLaptop "laptop${toString n}";
    }) (lib.range 1 19));
    };
  };
}
