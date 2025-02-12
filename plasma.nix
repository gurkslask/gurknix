{ pkgs, ...}:
{
  imports = [
    <plasma-manager/modules>
  ];

  programs = {
    plasma = {
      enable = true;
      # etc.
      workspace = {
           lookAndFeel = "org.kde.breezedark.desktop";
      };
    };
  };
}
