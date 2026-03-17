{pkgs, system, ...}:
{
homebrew = {
  enable = true;
  onActivation.cleanup = "zap";
  casks = [
    "iterm2"
    "raycast"
    "orbstack"
    "rectangle"
    "visual-studio-code"
    "stats"
    "spotify" # Man måste ju ha musik när man kodar
  ];
};
}
