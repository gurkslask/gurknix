{pkgs, system, ...}:
{
homebrew = {
  enable = true;
  onActivation.cleanup = "zap";
  casks = [
    "git"
    "iterm2"
    "raycast"
  ];
};
}
