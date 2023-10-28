{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.file-roller
    feh
  ];

  programs.thunar.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.tumbler.enable = true; # Thumbnail support for images
}
