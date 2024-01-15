{ pkgs, ... }:{

  home.packages = with pkgs; [ 
    rustc
    cargo
    gcc
    rust-analyzer
    rustfmt 
    clippy 
  ];

}
