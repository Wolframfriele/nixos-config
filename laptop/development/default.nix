{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./python.nix
    ./lf.nix
    ./starship.nix
  ];
  
  home.packages = with pkgs; [
    vscode
    ripgrep
    fzf
    tree
  ];
}
