require("lsp-format").setup {}
require("lspconfig").ruff_lsp.setup { on_attach = require("lsp-format").on_attach }