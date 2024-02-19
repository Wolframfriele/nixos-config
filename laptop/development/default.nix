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
    gitui
    zola
    minify
    gnumake
    neovide
    rpi-imager 
    jdk21
    maven
  ];
}
