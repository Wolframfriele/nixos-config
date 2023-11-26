{ config, pkgs, inputs, ... }:

{
  programs.neovim ={
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp

      lsp-format-nvim

      neodev-nvim
      vim-nix

      luasnip
      friendly-snippets

      indent-blankline-nvim
      nvim-web-devicons
      telescope-fzf-native-nvim
      
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = "require('nvim-autopairs').setup()";
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require("which-key")
          wk.register(mappings, opts)
        '';
      }
      
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/lsp.lua;
      }

      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/null-sl.lua;
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/cmp.lua;
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-rust
          p.tree-sitter-go
          p.tree-sitter-json
        ]));
        type = "lua";
        config = builtins.readFile ./plugins/treesitter.lua;
      }

      {
        plugin = oxocarbon-nvim;
        config = "colorscheme oxocarbon";
      }

       
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = "require('nvim-tree').setup()";
      }

      {
        plugin = lualine-nvim;
        type = "lua";
        config = "require('lualine').setup()";
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/telescope.lua;
      }
      
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }
      (fromGitHub "HEAD" "nvimdev/guard.nvim")
    ];

    extraLuaConfig = builtins.readFile ./plugins/options.lua;

    extraPackages = with pkgs; [
      wl-clipboard

      efm-langserver

      lua-language-server
      rnix-lsp
      pyright
      black
      ruff
      mypy
      fd
    ];
  };
} 
