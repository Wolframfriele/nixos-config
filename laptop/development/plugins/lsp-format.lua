require("lsp-format").setup {}
local on_attach = function(client)
    require("lsp-format").on_attach(client)
end

vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]

lsp.efm.setup {
  init_options = {documentFormatting = true},
  settings = {
      rootMarkers = { ".git/", "pyproject.toml" },
      languages = {
          python = { { formatCommand = "black -", formatStdin = true }, },
      }
  },
  on_attach = on_attach,
}