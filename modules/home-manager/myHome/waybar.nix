{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      margin-top = 8;
      margin-left = 10;
      margin-right = 10;
      spacing = 4;

      modules-left = [ "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "pulseaudio" "battery" "tray" ];

      "niri/window" = {
        format = "󰣆  {title}";
        max-length = 50;
        separate-outputs = true;
      };

      "clock" = {
        format = "<b>{:%H:%M}</b>";
        format-alt = "󰃭  {:%A, %d %B}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
      };

      "network" = {
        format-wifi = "   {essid}";
        format-ethernet = "󰈀  {ifname}";
        format-disconnected = "⚠  Disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
        on-click = "plasmawindowed org.kde.plasma.networkmanagement
"; # Öppnar KDE:s nätverksinställningar
      };

      "pulseaudio" = {
        format = "{icon}  {volume}%";
        format-muted = "󰝟  Muted";
        format-icons = {
          default = [ "" "" "" ];
        };
        on-click = " plasmawindowed org.kde.plasma.volume";
      };

      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}  {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      "tray" = {
        icon-size = 18;
        spacing = 10;
      };
    }];

    # Här kommer magin som gör att den ser "fräck" ut
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0); /* Helt genomskinlig bar */
      }

      /* Gemensam stil för alla "piller" */
      #workspaces, #clock, #network, #pulseaudio, #battery, #tray, #window {
        background: #1e1e2e; /* Catppuccin Mocha färg, eller välj din egen */
        color: #cdd6f4;
        padding: 0px 15px;
        border-radius: 12px;
        margin: 4px 2px;
        border: 1px solid rgba(255, 255, 255, 0.1);
      }

      #window {
        color: #b4befe;
        font-weight: bold;
      }

      #clock {
        color: #fab387;
      }

      #network {
        color: #a6e3a1;
      }

      #pulseaudio {
        color: #89b4fa;
      }

      #battery.critical {
        color: #f38ba8;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to { background-color: #f38ba8; color: #1e1e2e; }
      }
    '';
  };
}
