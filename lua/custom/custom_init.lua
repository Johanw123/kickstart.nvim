-- Custom
local opt = vim.opt
opt.termguicolors = true
opt.cindent = true
opt.relativenumber = true
opt.wrap = false
opt.cmdheight = 0
vim.g.have_nerd_font = true

vim.g.OmniSharp_highlighting = 1
vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_selector_ui = 'fzf'

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

vim.g.mapleader = " "