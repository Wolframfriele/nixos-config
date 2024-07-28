vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 300

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

vim.o.smartindent = true
vim.o.wrap = false

vim.o.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
--vim.o.colorcolumn = 80

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Cancell me edit
vim.keymap.set("i", "<C-t>", "<Esc>")

-- Ctrl + backspace to delete word
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', {noremap = true})


-- Nvim Tree keybindings
vim.keymap.set("n", "<Leader>tt", ":NvimTreeToggle<CR>", {})
vim.keymap.set("n", "<Leader>tf", ":NvimTreeFocus<CR>", {})

-- Telescope keybindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<Leader>fh", builtin.help_tags, {})

-- Zenmode keybindings
vim.keymap.set("n", "<Leader>c", ":ZenMode<CR>", {})

-- paste over word without yanking the deleted word
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank to clipboard 
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

