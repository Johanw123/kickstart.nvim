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

local highlight = {
    "IndentLineColor",
  }
  
  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IndentLineColor", { fg = "#2b303c" })
  end)

--   hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
--   hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
  
  require("ibl").setup { indent = { highlight = highlight } }