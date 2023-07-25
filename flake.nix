#
#  NixOS config for my systems, mostly stolen from https://github.com/MatthiasBenaets/nixos-config
#  Check https://www.youtube.com/watch?v=AGVXJ-TIv3Y for a great mini course.
#
#  flake.nix *             
#   └─ ./hosts
#       └─ default.nix
#

{
  description = "My Personal NixOS Flake Configuration";

  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                     # Default Stable Nix Packages
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixgl = {                                                             # OpenGL
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland = {                                                          # Official Hyprland flake
        url = "github:vaxerski/Hyprland";                                   # Add "hyprland.nixosModules.default" to the host modules
        inputs.nixpkgs.follows = "nixpkgs";
      };   
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nixgl, hyprland, ... }:   # Function that tells my flake which to use and what do what to do with the dependencies.
    let                                                                     # Variables that can be used in the config files.
      user = "wolf";
      location = "$HOME/.setup";
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager user location hyprland;   # Also inherit home-manager so it does not need to be defined here.
        }
      );
    };
}
