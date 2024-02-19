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
    ./creative
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
    # obsidian
  ];

    
  programs.git = {
    # Install git
    enable = true;
    
    # Additional options for the git program
    # package = pkgs.gitAndTools.gitFull; # Install git wiith all the optional extras
    userName = "Wolfram Friele";
    userEmail = "wolframfriele@gmail.com";
    extraConfig = {
      # Use vim as our default git editor
      # core.editor = "vim";
      # Cache git credentials for 15 minutes
      credential.helper = "cache";
      init.defaultBranch = "main";
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

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
