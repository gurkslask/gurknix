{ pkgs, ... }:

{
  # Fish-konfiguration
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Stäng av välkomstmeddelandet
    '';
    shellAliases = {
      ls = "eza --icons"; # Notera: exa har bytt namn till eza i nyare paket
      ll = "eza -l --icons";
      la = "eza -la --icons";
      tree = "eza --tree --icons";
      # Git-alias
      gs = "git status";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      gb = "git branch";
      gco = "git checkout";
      glg = "git log --oneline --graph --decorate"; # Snygg historik i terminalen
      gcm = "git checkout main"; # Eller 'master' beroende på vad du använder
      # Alias restart wireplumber
      rewp = "sudo systemctl --user restart wireplumber";
    };
  };
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
# Lägg till lite färg och stil (Catppuccin-inspirerat)
    colors = {
      bg = "-1";
      "bg+" = "-1";
      hl = "#ed8796";
      "hl+" = "#ed8796";
      info = "#91d7e3";
      prompt = "#8aadf4";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      spinner = "#f4dbd6";
      header = "#ed8796";
    };

    # Förhandsvisning! När du bläddrar i filer ser du innehållet till höger
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };

  programs.starship = {
    enable = true;
    settings = {
      # "format" bestämmer ordningen på allt som visas längst fram
      format = ''
$directory$git_branch$git_status$nix_shell$character
'';

      add_newline = false;

      # Konfiguration för mappen du står i
      directory = {
        style = "bold blue";
        truncation_length = 3;
        fish_style_pwd_dir_length = 1; # Gör långa sökvägar kortare om det behövs
      };

      # Konfiguration för Git
      git_branch = {
        symbol = "🌿 ";
        style = "bold magenta";
      };

      git_status = {
        style = "bold red";
      };

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
  # Eza (ersättaren till ls)
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };
}
