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
vim.o.updatetime = 300

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

local group = vim.api.nvim_create_augroup("Black", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
	pattern = "*.py",
	command = "silent !black %",
	group = group,
})