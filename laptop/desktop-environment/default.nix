{pkgs, hyprland, ...}: {
  imports = [
    ./hyprland.nix
    ./gtk.nix
    ./waybar.nix
    ./gtk.nix
    #./anyrun.nix
    # ./wayland-apps.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
    pavucontrol
    # grim 
    # slurp 
    # inputs.hyprland-contrib.packages.x86_64-linux.grimblast 
  ];

  # music player - mpd
  # home.file.".config/mpd" = {
  #   source = ./mpd;
  #   recursive = true;
  # };

# allow fontconfig to discover fonts and configurations installed through home.packages
  # fonts.fontconfig.enable = true;
 
}
