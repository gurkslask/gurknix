{ pkgs, ... }:

{
  # Aktivera niri via den officiella NixOS-modulen
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    # Nödvändiga grejer för en bra upplevelse
    xwayland # För appar som inte stödjer Wayland än
    waybar   # Statusrad (Niri har ingen egen)
    swaybg   # För bakgrundsbilder
    alacritty # Eller din favorit-terminal
    fuzzel    # En snabb app-launcher som passar Niri bra
  ];

  # För att KDE-appar ska se bra ut (teman etc.)
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };
}
