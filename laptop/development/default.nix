{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./python.nix
  ];
  
  home.packages = with pkgs; [
    vscode
  ];
}
