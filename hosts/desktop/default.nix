#
#  Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./desktop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktop
#       │   ├─ ./hyprland
#       │   │   └─ default.nix
#       │   └─ ./virtualisation
#       │       └─ default.nix
#       ├─ ./programs
#       │   └─ games.nix
#       └─ ./hardware
#           └─ default.nix
#

{ pkgs, lib, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [(import ../../modules/desktop/hyprland/default.nix)] ++ # Window Manager
    (import ../../modules/hardware);                      # Hardware devices
    #[(import ../../modules/hardware/dslr.nix)] ++         # Temp Fix DSLR Webcam
    #(import ../../modules/desktop/virtualisation) ++      # Virtual Machines & VNC
    #[(import ../../modules/programs/games.nix)] ++        # Gaming
    #[(import ../../modules/programs/flatpak.nix)] ++        # Gaming

  boot = {                                      # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "nvidia" ];        # Video drivers

    loader = {                                  # For legacy boot:
      systemd-boot = {
        enable = true;
        configurationLimit = 5;                 # Limit the amount of configurations
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;                              # Grub auto select time
    };
  };

  hardware = {
    # sane = {                                    # Used for scanning with Xsane
    #   enable = true;
    #   extraBackends = [ pkgs.sane-airscan ];
    # };
    opengl = {
      enable = true;
      # extraPackages = with pkgs; [
        
      # ];
      # extraPackages32 = with pkgs; [
      #   driversi686Linux.amdvlk
      # ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment = {                               # Packages installed system wide
    systemPackages = with pkgs; [               # This is because some options need to be configured.
      # x11vnc
      # clinfo
    ];
    #variables = {
    #  LIBVA_DRIVER_NAME = "i965";
    #};
  };

  services = {
    blueman.enable = true;                      # Bluetooth
    # samba = {                                   # File Sharing over local network
    #   enable = true;                            # Don't forget to set a password:  $ smbpasswd -a <user>
    #   shares = {
    #     share = {
    #       "path" = "/home/${user}";
    #       "guest ok" = "yes";
    #       "read only" = "no";
    #     };
    #   };
    #   openFirewall = true;
    # };
  };

}
