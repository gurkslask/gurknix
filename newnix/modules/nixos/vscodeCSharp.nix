{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dotnet-sdk # Själva kompilatorn och runtime
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-dotnettools.csharp # C# stöd i VS Code
        ms-dotnettools.vscode-dotnet-runtime
      ];
    })
  ];
}
