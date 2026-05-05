{ pkgs, config, lib, ... }:

{
  programs.niri = {
    enable = true;
    # Här skriver vi själva konfigurationen i KDL-format
    config = ''
      input {
          keyboard {
              xkb {
                  layout "se" # Svenskt tangentbord
              }
          }
          touchpad {
              tap
              natural-scroll
          }
      }

      output "eDP-1" { # Ändra till ditt skärmnamn (kör 'niri msg outputs')
          mode "1920x1080@60.000"
          scale 1.0
      }

      layout {
          gaps 16
          center-focused-column-indicator
          default-column-width { proportion 0.5; }
      }

      spawn-at-startup "waybar"
      spawn-at-startup "swaybg -m fill -i ~/Pictures/wallpaper.jpg"

      binds {
          // Terminal (anpassa efter vad du kör, t.ex. kitty eller alacritty)
          "Mod+Return" { spawn "alacritty"; }
          "Mod+D" { spawn "fuzzel"; }
          
          // KDE Program i Niri
          "Mod+E" { spawn "dolphin"; }
          "Mod+Comma" { spawn "systemsettings"; }

          // Navigering
          "Mod+Left"  { focus-column-left; }
          "Mod+Right" { focus-column-right; }
          "Mod+Up"    { focus-window-up; }
          "Mod+Down"  { focus-window-down; }

          // Flytta fönster
          "Mod+Shift+Left"  { move-column-left; }
          "Mod+Shift+Right" { move-column-right; }

          // Storlek & Layout
          "Mod+R" { switch-preset-column-width; }
          "Mod+F" { maximize-column; }
          "Mod+Shift+F" { fullscreen-window; }

          // Stäng fönster & Exit
          "Mod+Q" { close-window; }
          "Mod+Shift+E" { quit; }
      }

      // Estetik för fönster
      window-rule {
          draw-border-with-background false
          geometry-corner-radius 12
          clip-to-geometry true
      }
    '';
  };

  # Vi ser till att waybar och fuzzel finns med i din user-miljö
  home.packages = with pkgs; [
    waybar
    fuzzel
    swaybg
  ];
}
