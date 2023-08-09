{pkgs, hyprland, ...}: {
  imports = [
    ./hyprland.nix
    # ./waybar.nix
    # ./anyrun.nix
    # ./wayland-apps.nix
  ];

  # music player - mpd
  # home.file.".config/mpd" = {
  #   source = ./mpd;
  #   recursive = true;
  # };

  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
    pavucontrol
    # grim 
    # slurp 
    # inputs.hyprland-contrib.packages.x86_64-linux.grimblast 
  ];
  # wayland.windowManager.hyprland.enable = true;
  # allow fontconfig to discover fonts and configurations installed through home.packages
  # fonts.fontconfig.enable = true;
 
}
