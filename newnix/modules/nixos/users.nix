{ inputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  home-manager.users.alex = import ../../home-manager/home_alex.nix;
  # home-manager.users.admin = import ../../home-manager/home_admin.nix;
}
