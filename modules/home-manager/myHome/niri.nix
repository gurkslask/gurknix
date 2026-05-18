{ inputs, pkgs, programs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    settings = {
      input = {
          keyboard =  {
              repeat-delay = 200;
              xkb  = {
                  layout =  "se";
              };
          };
          touchpad = {
              tap = true;
              natural-scroll = false;
          };
      };
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
            "konsole"
          ];
        }
      ];
      layout = {
      gaps = 16;
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width = { proportion = 0.5; };

      focus-ring = {
        width = 4;
        active.color = "#7fc8ff";
        inactive.color = "#505050";
      };

      border = {
        enable = false; # "off" i KDL
        width = 4;
        active.color = "#ffc87f";
        inactive.color = "#505050";
        urgent.color = "#9b0000";
      };
      
      # shadow = { enable = false; ... }; # Shadow var utkommenterad i din config
      # struts = {}; 
    };
    window-rules = [
      {
        # Workaround för WezTerm
        matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
        default-column-width = {};
      }
      {
        # Öppna Firefox Picture-in-Picture flytande
        matches = [ { app-id = "firefox$"; title = "^Picture-in-Picture$"; } ];
        open-floating = true;
      }
    ];

    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};

      # Program
      "Mod+T".action = {spawn = ["Konsole"];};
      "Mod+D".action = { spawn = ["fuzzel"]; };
      "Super+Alt+L".action = {spawn = ["swaylock"];};

      "Super+Alt+S" = {
        allow-when-locked = true;
        action.spawn-sh = [ "pkill orca || exec orca" ];
      };

      # Ljudkontroller via PipeWire & WirePlumber
      "XF86AudioRaiseVolume" = { allow-when-locked = true; action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0" ]; };
      "XF86AudioLowerVolume" = { allow-when-locked = true; action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-" ]; };
      "XF86AudioMute" = { allow-when-locked = true; action.spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ]; };
      "XF86AudioMicMute" = { allow-when-locked = true; action.spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" ]; };

      # Mediakontroller via playerctl
      "XF86AudioPlay" = { allow-when-locked = true; action.spawn-sh = [ "playerctl play-pause" ]; };
      "XF86AudioStop" = { allow-when-locked = true; action.spawn-sh = [ "playerctl stop" ]; };
      "XF86AudioPrev" = { allow-when-locked = true; action.spawn-sh = [ "playerctl previous" ]; };
      "XF86AudioNext" = { allow-when-locked = true; action.spawn-sh = [ "playerctl next" ]; };

      # Ljusstyrka
      "XF86MonBrightnessUp" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ]; };
      "XF86MonBrightnessDown" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ]; };

      # Window management & Overview
      "Mod+O" = { repeat = false; action.toggle-overview = {}; };
      "Mod+Q" = { repeat = false; action.close-window = {}; };

      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      "Mod+Ctrl+Left".action.move-column-left = {};
      "Mod+Ctrl+Down".action.move-window-down = {};
      "Mod+Ctrl+Up".action.move-window-up = {};
      "Mod+Ctrl+Right".action.move-column-right = {};
      "Mod+Ctrl+H".action.move-column-left = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};
      "Mod+Ctrl+L".action.move-column-right = {};

      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};
      "Mod+Ctrl+Home".action.move-column-to-first = {};
      "Mod+Ctrl+End".action.move-column-to-last = {};

      # Monitor management
      "Mod+Shift+Left".action.focus-monitor-left = {};
      "Mod+Shift+Down".action.focus-monitor-down = {};
      "Mod+Shift+Up".action.focus-monitor-up = {};
      "Mod+Shift+Right".action.focus-monitor-right = {};
      "Mod+Shift+H".action.focus-monitor-left = {};
      "Mod+Shift+J".action.focus-monitor-down = {};
      "Mod+Shift+K".action.focus-monitor-up = {};
      "Mod+Shift+L".action.focus-monitor-right = {};

      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

      # Workspace management
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+U".action.focus-workspace-down = {};
      "Mod+I".action.focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};
      "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+I".action.move-column-to-workspace-up = {};

      "Mod+Shift+Page_Down".action.move-workspace-down = {};
      "Mod+Shift+Page_Up".action.move-workspace-up = {};
      "Mod+Shift+U".action.move-workspace-down = {};
      "Mod+Shift+I".action.move-workspace-up = {};

      # Scroll-binds
      "Mod+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = {}; };
      "Mod+WheelScrollUp" = { cooldown-ms = 150; action.focus-workspace-up = {}; };
      "Mod+Ctrl+WheelScrollDown" = { cooldown-ms = 150; action.move-column-to-workspace-down = {}; };
      "Mod+Ctrl+WheelScrollUp" = { cooldown-ms = 150; action.move-column-to-workspace-up = {}; };

      "Mod+WheelScrollRight".action.focus-column-right = {};
      "Mod+WheelScrollLeft".action.focus-column-left = {};
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = {};
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = {};

      "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
      "Mod+Shift+WheelScrollUp".action.focus-column-left = {};
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = {};
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = {};

      # Workspaces via siffror
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # Kolumnmanipulation
      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};
      "Mod+Comma".action.consume-window-into-column = {};
      "Mod+Period".action.expel-window-from-column = {};

      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.switch-preset-window-height = {};
      "Mod+Ctrl+R".action.reset-window-height = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+Ctrl+F".action.expand-column-to-available-width = {};
      "Mod+C".action.center-column = {};
      "Mod+Ctrl+C".action.center-visible-columns = {};

      # Storleksjusteringar
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Ctrl+Minus".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Ctrl+Minus".action.set-window-height = "+10%";

      # Layout toggles
      "Mod+V".action.toggle-window-floating = {};
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};
      "Mod+W".action.toggle-column-tabbed-display = {};

# Screenshots
      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      # Systemhantering
      "Mod+Escape" = {
        allow-inhibiting = false;
        action.toggle-keyboard-shortcuts-inhibit = {};
      };

      "Mod+Shift+E".action.quit = {};
      "Ctrl+Alt+Delete".action.quit = {};
      "Mod+Shift+P".action.power-off-monitors = {};
    };
  };
};

      /*binds = {
        "Mod+Return".action = { spawn = ["konsole"]; };
        "Mod+D".action = { spawn = ["fuzzel"]; };
        "Mod+E".action = { spawn = ["dolphin"]; };
        "Mod+N".action = { spawn = ["noctalia-shell"]; };
        "Mod+Comma".action = { spawn = ["systemsettings"]; };

        "Mod+Left".action =  { focus-column-left = []; };
        "Mod+Right".action = { focus-column-right = []; };
        "Mod+Up".action =    { focus-window-up = []; };
        "Mod+Down".action =  { focus-window-down = []; };

        "Mod+Shift+Left".action =  { move-column-left = []; };
        "Mod+Shift+Right".action = { move-column-right = []; };


        "Mod+Minus".action = { set-column-width = ["-10%"]; };
        "Mod+Equal".action = { set-column-width = ["+10%"]; };

        "Mod+R".action = { switch-preset-column-width = []; };
        "Mod+F".action = { maximize-column = []; };
        "Mod+Shift+F".action = { fullscreen-window = []; };

        "Mod+Q".action = { close-window = []; };
        "Mod+Shift+E".action = { quit = []; };
      };
    };
  };*/
  # Vi ser till att waybar och fuzzel finns med i din user-miljö
  home.packages = with pkgs; [
    fuzzel
    brightnessctl
    
  ];
  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/alex/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Kalmar, Sweden";
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}
  /*xdg.configFile."niri/config.kdl" = {
    text = ''
      input {
          keyboard {
              xkb {
                  layout "se"
              }
          }
          touchpad {
              tap
              natural-scroll
          }
      }


      layout {
          gaps 16
          default-column-width { proportion 0.5; }
      }

      spawn-at-startup "noctalia"
      spawn-at-startup "swaybg -m fill -i /home/alex/Pictures/Wallpapers/yMOl6mr.png"

      binds {
          // Terminal (anpassa efter vad du kör, t.ex. kitty eller alacritty)
          "Mod+Return" { spawn "konsole"; }
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
    force = true;
  };*/

