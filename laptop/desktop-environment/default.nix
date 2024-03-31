{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./gtk.nix
    ./waybar.nix
    ./gtk.nix
    ./mako.nix
    ./anyrun.nix
    ./file-browsing.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
    pavucontrol
    playerctl
    vial
    vlc
  ];
  # music player - mpd
  # home.file.".config/mpd" = {
  #   source = ./mpd;
  #   recursive = true;
  # };
 
# allow fontconfig to discover fonts and configurations installed through home.packages
  # fonts.fontconfig.enable = true;
 
}
