#
#  flake.nix *             
#   └─ ./hosts
#       └─ default.nix
#

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, hyprland, anyrun, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./laptop/configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wolf = import ./laptop/home.nix;
            home-manager.extraSpecialArgs = { inherit anyrun hyprland; };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

          # hyprland.nixosModules.default {
          #   programs.hyprland.enable = true;
          # }
          # anyrun.homeManagerModules.default 
        ];
      };
    };
  };
}
