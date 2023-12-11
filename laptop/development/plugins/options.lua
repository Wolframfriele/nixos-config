vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Copy and paste to clipboard
vim.api.nvim_set_keymap("n", "<C-c>", '"+y$', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", "<C-v>", '"+p$', {noremap=true, silent=true})

-- Nvim Tree keybindings
vim.keymap.set("n", "<Leader>tt", ":NvimTreeToggle<CR>", {})
vim.keymap.set("n", "<Leader>tf", ":NvimTreeFocus<CR>", {})

-- Telescope keybindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<Leader>fh", builtin.help_tags, {})

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 300

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4


