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
    ripgrep
    fzf
    tree
    gitui
    zola
    minify
    gnumake
    rpi-imager 
    jdk21
    gradle
    jetbrains.idea-community
  ];
 
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}


