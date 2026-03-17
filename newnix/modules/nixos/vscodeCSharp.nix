{ pkgs, ... }:

let
  # Vi definierar vår .NET-miljö
  dotnet-sdk = with pkgs.dotnetCorePackages; combinePackages [
    sdk_9_0
    runtime_9_0
    aspnetcore_9_0
  ];

  # Vi skapar en anpassad VS Code FHS med tilläggen inkluderade
  my-vscode = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscode-fhs; # Vi tvingar den att använda FHS-versionen som bas
    vscodeExtensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      ms-dotnettools.vscode-dotnet-runtime
      jnoortheen.nix-ide
    ];
  };
in
{
  environment.systemPackages = [
    my-vscode
    dotnet-sdk
  ];

  # Miljövariabler som behövs inuti och utanför FHS
  environment.sessionVariables = {
    DOTNET_ROOT = "${dotnet-sdk}";
    DOTNET_BUNDLE_EXTRACT_BASE_DIR = "$HOME/.cache/dotnet_bundle_extract";
  };

  # Nix-ld är fortfarande bra att ha som backup för externa binärer
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    openssl
    zlib
    curl
  ];

  # Höjer gränsen för filövervakning (viktigt för C#-projekt)
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };
}
