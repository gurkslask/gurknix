{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #dotnet-sdk # Själva kompilatorn och runtime
    dotnet-sdk_9 # Själva kompilatorn och runtime
    dotnetCorePackages.sdk_9_0-bin
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-dotnettools.csharp # C# stöd i VS Code
        ms-dotnettools.csdevkit
        ms-dotnettools.vscode-dotnet-runtime
        jnoortheen.nix-ide
        
      ];
    })
  ];
}
