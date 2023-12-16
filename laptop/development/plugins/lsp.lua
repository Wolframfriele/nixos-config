-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-u>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-e>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Lua

require('neodev').setup()
require("lsp-format").setup {}
require'lspconfig'.lua_ls.setup {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          }
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
    end
  }

-- Nix

require('lspconfig').rnix.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}


-- Golang

require('lspconfig').gopls.setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            gofumpt = true
        }
    }
})


local group_go = vim.api.nvim_create_augroup("gofumpt", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
	pattern = "*.go",
	command = "silent !gofumpt -w %",
	group = group_go,
})

-- Python 

require('lspconfig').pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
 }

local on_attach_ruff = function(client, bufnr)
  -- Disable hover in favor of Pyright
  client.server_capabilities.hoverProvider = false
end

require('lspconfig').ruff_lsp.setup {
    on_attach = on_attach_ruff,
    capabilities = capabilities,
    init_options = {
        settings = {
          -- ...
        },
      },
      commands = {
        RuffAutofix = {
            function()
                vim.lsp.buf.execute_command {
                    command = 'ruff.applyAutofix',
                    arguments = {
                        { uri = vim.uri_from_bufnr(0) },
                    },
                }
            end,
          description = 'Ruff: Fix all auto-fixable problems',
        },
        RuffOrganizeImports = {
          function()
            vim.lsp.buf.execute_command {
              command = 'ruff.applyOrganizeImports',
              arguments = {
                { uri = vim.uri_from_bufnr(0) },
              },
            }
          end,
          description = 'Ruff: Format imports',
        },
        RuffFormat = {
            function()
            vim.lsp.buf.execute_command {
              command = 'ruff.applyFormat',
              arguments = {
                { uri = vim.uri_from_bufnr(0) },
              },
            }
          end,
          description = 'Ruff: Format code',
        },
    },
}

local group_ruff_format = vim.api.nvim_create_augroup("Ruff", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
	pattern = "*.py",
	command = "RuffFormat",
	group = group_ruff_format,
})

