{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./python.nix
    ./lf.nix
  ];
  
  home.packages = with pkgs; [
    vscode
    ripgrep
    fzf
    tree
  ];
}
