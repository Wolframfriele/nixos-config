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
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.wolf = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
