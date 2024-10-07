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
    logseq
    syncthing
    maestral
    wl-clipboard
    networkmanagerapplet
    pavucontrol
    playerctl
    vial
    vlc
    chromium
  ];
  # music player - mpd
  # home.file.".config/mpd" = {
  #   source = ./mpd;
  #   recursive = true;
  # };
 
# allow fontconfig to discover fonts and configurations installed through home.packages
  # fonts.fontconfig.enable = true;
 
}
