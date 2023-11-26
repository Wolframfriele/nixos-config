{
  programs.neovim = {
    extraPackages = [
      pkgs.efm-langserver
      # I personally install black through project-specific flake.nix/shell.nix files,
      # but might as well add it here as well
      pkgs.black
    ];
    plugins = [
      pkgs.vimPlugins.lsp-format-nvim
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/null-ls.lua;
      }
    ]
  }
}