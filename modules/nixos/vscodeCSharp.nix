{ pkgs, ... }:

let
  # Vi definierar SDK:n här så vi kan återanvända den i DOTNET_ROOT
  dotnet-sdk = with pkgs.dotnetCorePackages; combinePackages [
    sdk_9_0
    runtime_9_0
    aspnetcore_9_0 # Bra att ha om du ska köra webbprojekt senare
  ];
in
{
  environment.systemPackages = with pkgs; [
    dotnet-sdk
    
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-dotnettools.csharp
        ms-dotnettools.csdevkit
        ms-dotnettools.vscode-dotnet-runtime
        jnoortheen.nix-ide
      ];
    })
  ];

  # Nix-ld är din bästa vän för C# i VS Code
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    icu
    openssl
    curl
    lttng-ust      # Krävs ofta av .NET Core för spårning
    libkrb5        # Krävs för GSSAPI/Auth
    linux-pam      # Ibland nödvändigt för auth-moduler
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${dotnet-sdk}";
    DOTNET_BUNDLE_EXTRACT_BASE_DIR = "$HOME/.cache/dotnet_bundle_extract";
    
    # Denna rad hjälper VS Code tilläggen att hitta rätt 'dotnet' binär direkt
    PATH = [ "${dotnet-sdk}/bin" ];
  };

  # Fix för inotify (viktigt när projektet växer, annars kraschar Omnisharp/Roslyn)
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };
}