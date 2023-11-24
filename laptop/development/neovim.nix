{ config, pkgs, ... }:

{
  programs.neovim =
  let
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = toLuaFile .plugins/lsp.lua;
      }

      {
        plugin = nvim-cmp;
        type = "lua";
        config =  /* lua */ ''
          local cmp = require('cmp')
          local luasnip = require('luasnip')

          require('luasnip.loaders.from_vscode').lazy_load()
          luasnip.config.setup {}

          cmp.setup {
              snippet = {
                  expand = function(args)
                      luasnip.lsp_expand(args.body)
                  end,
              },
              mapping = cmp.mapping.preset.insert {
                  ['<C-n>'] = cmp.mapping.select_next_item(),
                  ['<C-p>'] = cmp.mapping.select_prev_item(),
                  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete {},
                  ['<CR>'] = cmp.mapping.confirm {
                      behavior = cmp.ConfirmBehavior.Replace,
                      select = true,
                  },
                  ['<Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                          cmp.select_next_item()
                      elseif luasnip.expand_or_locally_jumpable() then
                          luasnip.expand_or_jump()
                      else
                          fallback()
                      end
                  end, { 'i', 's' }),
                  ['<S-Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                          cmp.select_prev_item()
                      elseif luasnip.locally_jumpable(-1) then
                          luasnip.jump(-1)
                      else
                          fallback()
                      end
                  end, { 'i', 's' }),
              },
              sources = {
                  { name = 'nvim_lsp' },
                  { name = 'luasnip' },
              },
          }
        '';
      }

      {
        plugin = null-ls-nvim;
        type = "lua";
        config = ''
          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          local null_ls = require('null-ls')

          local opts = {
            sources = {
              null_ls.builtins.diagnostics.mypy,
              null_ls.builtins.diagnostics.ruff,
              null_ls.builtins.diagnostics.black,
            },
            on_attach = function(client, bufnr)
              if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({
                  group = augroup,
                  buffer = bufnr,
                })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                  end,
                })
              end
            end,
          }
        '';
      }

      nvim-cmp
      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      neodev-nvim
      vim-nix

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        type = "lua";
        config = /* lua */ ''
          require('nvim-treesitter.configs').setup {
          ensure_installed = {},

          auto_install = false,

          highlight = { enable = true },

          indent = { enable = true },
          }
        '';
      }

      {
        plugin = oxocarbon-nvim;
        config = "colorscheme oxocarbon";
      }

      nvim-web-devicons
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
      indentLine
      {
        plugin = telescope-nvim;
        type = "lua";
        config = /* lua */ ''
          require('telescope').setup({
          extensions = {
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true,  -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
              case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
            }
          }
          })  
          require('telescope').load_extension('fzf')
        '';
      }
      telescope-fzf-native-nvim
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }

    ];

    extraLuaConfig = /* lua */ ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      vim.keymap.set("n", "<Leader>tt", ":NvimTreeToggle<CR>", {})
      vim.keymap.set("n", "<Leader>tf", ":NvimTreeFocus<CR>", {})

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<Leader>fh", builtin.help_tags, {})
      
      vim.o.number = true
      -- vim.o.relativenumber = true

      vim.o.signcolumn = 'yes'

      vim.o.tabstop = 4
      vim.o.shiftwidth = 4
      vim.o.expandtab = true
      vim.o.softtabstop = 4
    '';

    extraPackages = with pkgs; [
      wl-clipboard

      lua-language-server
      rnix-lsp
      pyright
      black
      ruff
      mypy
    ];
  };
} 
