{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./lf.nix
    ./starship.nix
    ./python.nix
    ./rust.nix
    ./go.nix
    ./neovim.nix
  ];
  
  home.packages = with pkgs; [
    vscode
    ripgrep
    fzf
    tree
    zola
  ];
}
