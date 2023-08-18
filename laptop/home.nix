# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./desktop-environment
    ./development
    # inputs.anyrun.homeManagerModules.default
  ];

  home = {
    username = "wolf";
    homeDirectory = "/home/wolf";
  };

  # Add stuff for your user as you see fit:
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })

    firefox
    xfce.thunar
  ];

  programs.neovim.enable = true;
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;      
    };

    settings =
      {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        tab_bar_edge = "top";     # tab bar on top
        confirm_os_window_close = 0;
      };
  };

  # services = {                            # Applets
  #   blueman-applet.enable = true;         # Bluetooth
  #   network-manager-applet.enable = true; # Network
  #   cbatticon = {
  #     enable = true;
  #     criticalLevelPercent = 10;
  #     lowLevelPercent = 20;
  #     iconType = null;
  #   };
  # };
  # Enable home-manager and git
  programs.home-manager.enable = true;
  # programs.git.enable = true;

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
