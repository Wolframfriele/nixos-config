{pkgs, hyprland, ...}: {
  imports = [
    ./hyprland.nix
    ./gtk.nix
    ./waybar.nix
    ./gtk.nix
    ./mako.nix
    #./anyrun.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
    pavucontrol
    swayidle
  ];
  # music player - mpd
  # home.file.".config/mpd" = {
  #   source = ./mpd;
  #   recursive = true;
  # };

  # services.swayidle = {
  #   enable = true;
  #   systemdTarget = "hyprland-session.target";
  #   timeouts = [
  #     {
  #       timeout = 10;
  #       command = "hyprctl dispatch dpms";
  #     }
  #   ];
  # };

# allow fontconfig to discover fonts and configurations installed through home.packages
  # fonts.fontconfig.enable = true;
 
}
