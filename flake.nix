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
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

      # home-manager = {                                                      # User Package Management
      #   url = "github:nix-community/home-manager/release-23.05";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

      # nixgl = {                                                             # OpenGL
      #   url = "github:guibou/nixGL";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

      # hyprland = {                                                          # Official Hyprland flake
      #   url = "github:vaxerski/Hyprland";                                   # Add "hyprland.nixosModules.default" to the host modules
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };   
    };
  outputs = { self, nixpkgs }: {
    let
      user = "wolf";
      hostname = "laptop";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        
      }
    }
    
  };
}
