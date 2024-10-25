-- Custom
local opt = vim.opt
opt.termguicolors = true
opt.cindent = true
opt.relativenumber = true
opt.wrap = false
opt.cmdheight = 0
vim.g.have_nerd_font = true

opt.fillchars = { eob = ' ' }

vim.g.OmniSharp_highlighting = 1
vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_selector_ui = 'fzf'

vim.cmd 'language en_US'

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.linespace = 5

vim.g.mapleader = ' '

-- vim.g.indenltine_filetype_exclude = { 'help', 'dashboard', 'packer' }

if vim.g.neovide then
  --vim.g.neovide_transparency = 0.9
  --vim.g.transparency = 0.9
  --vim.g.neovide_background_color = "#332C2A" .. alpha()
  --vim.g.neovide_background_color = "#332C2A"

  vim.o.guifont = 'FiraCode NF'

  vim.g.neovide_floating_blur_amount_x = 2
  vim.g.neovide_floating_blur_amount_y = 2

  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_cursor_animation_length = 0
end

if vim.fn.has 'wsl' == 1 then
  package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
  package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'
  package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/magick/init.lua;'

  -- vim.opt.shell = "kitty"
  -- vim.opt.shellcmdflag = "--detach"
  vim.opt.shell = 'zsh'
elseif vim.fn.has 'win32' == 1 and vim.fn.has 'wsl' == 0 then
  local powershell_options = {
    shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
    shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
    shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
    shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
    shellquote = '',
    shellxquote = '',
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end

  package.path = package.path .. ';' .. vim.fn.expand '$APPDATA' .. '\\LuaRocks\\share\\lua\\5.1\\?\\init.lua;'
  package.path = package.path .. ';' .. vim.fn.expand '$APPDATA' .. '\\LuaRocks\\share\\lua\\5.1\\?.lua;'

  local avalonia_lsp_bin = 'C:\\Users\\johanw\\.vscode\\extensions\\avaloniateam.vscode-avalonia-0.0.31\\avaloniaServer\\AvaloniaLanguageServer.dll'

  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.axaml' },
    callback = function()
      vim.cmd.setfiletype 'xml'
      vim.lsp.start {
        name = 'Avalonia LSP',
        cmd = { 'dotnet', avalonia_lsp_bin },
        root_dir = vim.fn.getcwd(),
      }
    end,
  })
end

local highlight = {
  'IndentLineColor',
}

local hooks = require 'ibl.hooks'
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IndentLineColor', { fg = '#2b303c' })
end)

--   hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
--   hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

require('ibl').setup {
  indent = {
    highlight = highlight,
    char = '│',
  },
  exclude = {
    filetypes = {
      'help',
      'startify',
      'aerial',
      'alpha',
      'dashboard',
      'packer',
      'neogitstatus',
      'NvimTree',
      'neo-tree',
      'Trouble',
    },
    buftypes = {
      'nofile',
      'terminal',
    },
  },
}

vim.keymap.set('n', 'go', '<Cmd>ClangdSwitchSourceHeader<CR>', { desc = 'Switch header/source (C++)' })

-- Harpoon
vim.keymap.set('n', '<leader>ha', "<Cmd>lua require('harpoon.mark').add_file()<CR>", { desc = 'Add file' })
vim.keymap.set('n', '<leader>hr', "<Cmd>lua require('harpoon.mark').rm_file()<CR>", { desc = 'Remove file' })
vim.keymap.set('n', '<leader>hl', "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = 'Toggle quick menu' })
vim.keymap.set('n', '<leader>hn', "<Cmd>lua require('harpoon.ui').nav_next()<CR>", { desc = 'Navigate next file' })
vim.keymap.set('n', '<leader>hp', "<Cmd>lua require('harpoon.ui').nav_prev()<CR>", { desc = 'Navigate previous file' })

vim.keymap.set('n', '<leader>1', "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", { desc = 'Harpoon to file 1' })
vim.keymap.set('n', '<leader>2', "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", { desc = 'Harpoon to file 2' })
vim.keymap.set('n', '<leader>3', "<Cmd>lua require('harpoon.ui').nav_file(3)<CR>", { desc = 'Harpoon to file 3' })
vim.keymap.set('n', '<leader>4', "<Cmd>lua require('harpoon.ui').nav_file(4)<CR>", { desc = 'Harpoon to file 4' })
vim.keymap.set('n', '<leader>5', "<Cmd>lua require('harpoon.ui').nav_file(5)<CR>", { desc = 'Harpoon to file 5' })

-- Flash
vim.keymap.set('n', '<leader>fj', function()
  require('flash').jump()
end, { desc = 'Flash [J]ump' })
vim.keymap.set('n', '<leader>ft', function()
  require('flash').treesitter()
end, { desc = 'Flash Treesitter' })
vim.keymap.set('n', '<leader>fr', function()
  require('flash').treesitter_search()
end, { desc = 'Flash Treesitter Search' })

-- Buffer
vim.keymap.set('n', '<leader>bf', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })

-- LSP
vim.keymap.set('n', '<leader>lh', function()
  vim.lsp.buf.signature_help()
end, { desc = '[H]elp' })

-- Telescope
vim.keymap.set('n', '<leader>cd', require('telescope').extensions.zoxide.list, { desc = '[C]hange [D]irectory' })
--vim.keymap.set("n", "<leader>fs", function() require('telescope.builtin').grep_string() end, {desc = "[F]ind [S]tring"})
-- vim.keymap.set("n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, {desc = "[F]ind [R]eferences"})
vim.keymap.set('n', '<leader>sa', require('telescope').extensions.aerial.aerial, { desc = '[S]earch [A]erial' })

vim.keymap.set('n', '<Leader>pf', 'i<C-r><C-o>+<ESC>l=`[`]$', { desc = 'Paste block and indent' })

-- Precognition
-- vim.keymap.set('n', '<leader>p', 'lua require("precognition").peek()', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>tp', '<cmd> lua require("precognition").toggle()<cr>', { desc = ' Toggle Precognition' })

-- Set keymap for <leader>tt to run !start powershell and cmd to the current working directory
vim.keymap.set('n', '<leader>tt', function()
  -- get cwd and run cmd
  local cwd = vim.fn.getcwd()
  vim.fn.system { 'cmd', '/c', 'start', 'pwsh', '-NoExit' }
end, { noremap = true, silent = true, desc = 'Start powershell' })

-- vim.keymap.set('n', '<leader>lt',
--   function()
--     if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
--       vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
--     end
--   end, { desc = '[T]oggle Hints' })

vim.keymap.set('n', '<leader>o', function()
  local path = vim.fn.fnamemodify(vim.fn.expand '%:h', ':p')
  vim.fn.system { 'cmd', '/c', 'explorer', path }
end, { desc = 'Explore file location' })

vim.keymap.set({ 'n', 't' }, '<A-i>', function()
  require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' }
end)

vim.keymap.set({ 'n', 't' }, '<A-h>', function()
  require('nvchad.term').toggle { pos = 'sp', id = 'horizontalSplitTerm', size = 0.4 }
end)

vim.keymap.set({ 'n', 't' }, '<A-v>', function()
  require('nvchad.term').toggle { pos = 'vsp', id = 'verticalSplitTerm', size = 0.4 }
end)
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
--   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
-- }

require('which-key').add {
  { '<leader>b', group = '[B]uffer' },
  { '<leader>b_', hidden = true },
  { '<leader>f', group = '[F]lash' },
  { '<leader>f_', hidden = true },
  { '<leader>h', group = '[H]arpoon' },
  { '<leader>h_', hidden = true },
  { '<leader>l', group = '[L]sp' },
  { '<leader>l_', hidden = true },
}

vim.keymap.set('n', '<leader>ta', '<cmd>AerialToggle!<CR>', { desc = ' Toggle Aerial' })
vim.keymap.set('n', '<leader>tm', function()
  require('mini.map').toggle()
end, { desc = ' Toggle MiniMap' })

vim.keymap.set('n', '<leader>th', function()
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end
end, { desc = '[T]oggle [H]ints' })

vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR, wrap = true }
end, { desc = ' Diagnostics Next' })

vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR, wrap = true }
end, { desc = ' Diagnostics Next' })

vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR, wrap = true }
end, { desc = ' Diagnostics Next' })

vim.keymap.set('n', '<leader>dN', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR, wrap = true }
end, { desc = ' Diagnostics Next (Backwards)' })

vim.keymap.set({ 'v', 'n' }, '<leader>ca', require('actions-preview').code_actions, { desc = 'Code Actions' })

-- keys = {
--   {
--     '<leader>f',
--     function() require('conform').format { async = true, lsp_fallback = true } end,
--     mode = '',
--     desc = '[F]ormat buffer',
--   },

-- local data_path = vim.fn.stdpath("data")
-- vim.print(data_path)
-- require("roslyn").setup({
--   --on_attach = function(client, buffer)
--   --  on_attach(client, buffer)

--   --end,
--   capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
--   handlers = {
--     ["textdocument/definition"] = require('omnisharp_extended').handler,
--   }
-- })

-- set default off
require('precognition').toggle()

require('diffview').setup {
  diff_binaries = false, -- Show diffs for binaries
  enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
  git_cmd = { 'git' }, -- The git executable followed by default args.
  hg_cmd = { 'hg' }, -- The hg executable followed by default args.
  use_icons = true, -- Requires nvim-web-devicons
  show_help_hints = true, -- Show hints for how to open the help panel
  watch_index = true, -- Update views and index buffers when the git index changes.
  hooks = {
    diff_buf_win_enter = function(bufnr, winid, ctx)
      if ctx.layout_name:match '^diff2' then
        if ctx.symbol == 'a' then
          vim.opt_local.winhl = table.concat({
            'DiffAdd:DiffviewDiffAddAsDelete',
            'DiffDelete:DiffviewDiffDelete',
          }, ',')
        elseif ctx.symbol == 'b' then
          vim.opt_local.winhl = table.concat({
            'DiffDelete:DiffviewDiffDelete',
          }, ',')
        end
      end
    end,
  },
}

local hl = vim.api.nvim_set_hl

vim.g.OmniSharp_highlight_groups = {
  PropertyName = 'PropertyName',
  TypeParameterName = 'TypeParameterName',
  Structure = 'Structure',
  StaticSymbol = 'PropertyName',
  ParameterName = 'ParameterName',
  FieldName = 'FieldName',
  ClassName = 'ClassName',
  LocalName = 'LocalName',
}

local links = {
  ['@lsp.type.namespace'] = '@namespace',
  ['@lsp.type.type'] = '@type',
  ['@lsp.type.class'] = '@type',
  ['@lsp.type.enum'] = '@type',
  ['@lsp.type.interface'] = '@type',
  ['@lsp.type.struct'] = '@structure',
  ['@lsp.type.parameter'] = '@parameter',
  ['@lsp.type.variable'] = '@variable',
  ['@lsp.type.property'] = '@property',
  ['@lsp.type.enumMember'] = '@constant',
  ['@lsp.type.function'] = '@function',
  ['@lsp.type.method'] = '@method',
  ['@lsp.type.macro'] = '@macro',
  ['@lsp.type.decorator'] = '@function',
}

for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

--- C Sharp ---
vim.api.nvim_set_hl(0, 'PropertyName', { fg = '#9B59B6' })
vim.api.nvim_set_hl(0, '@type.builtin.c_sharp', { fg = '#6ab04c' })
vim.api.nvim_set_hl(0, '@keyword.c_sharp', { fg = '#6ab04c' })
vim.api.nvim_set_hl(0, '@type.qualifier.c_sharp', { fg = '#6ab04c' })
vim.api.nvim_set_hl(0, 'ParameterName', { fg = '#C57626' })

--- C++ ----
local keywords = '#6ab04c'

vim.api.nvim_set_hl(0, '@type.builtin.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@type.qualifier.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@conditional.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@repeat.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@boolean.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@constant.builtin.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@keyword.return.cpp', { fg = keywords })
vim.api.nvim_set_hl(0, '@keyword.return.cpp', { fg = keywords })

vim.api.nvim_set_hl(0, '@conditional.ternary.cpp', { fg = '#dfe6e9' })
vim.api.nvim_set_hl(0, '@lsp.type.property.cpp', { fg = '#9B59B6' })
vim.api.nvim_set_hl(0, '@lsp.type.macro.cpp', { fg = '#7ed6df' })

vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', { fg = '#eccc68' })

vim.api.nvim_create_autocmd('LspTokenUpdate', {
  callback = function(args)
    local token = args.data.token
    if
      token.type == 'class'
      --token.type == "variable"
      and token.modifiers.deduced
      --and not token.modifiers.readonly
    then
      --print(tprint(args.data))
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, 'MyMutableGlobalHL')
    end

    if
      token.type == 'class'
      --token.type == "variable"
      and token.modifiers.defaultLibrary
      --and not token.modifiers.readonly
    then
      --print(tprint(args.data))
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, 'DefaultClassType')
    end

    if
      token.type == 'type'
      --token.type == "variable"
      and token.modifiers.deduced
      --and not token.modifiers.readonly
    then
      --print(tprint(args.data))
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, 'MyMutableGlobalHL')
    end

    if
      token.type == 'type'
      --token.type == "variable"
      and token.modifiers.defaultLibrary
      --and not token.modifiers.readonly
    then
      --print(tprint(args.data))
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, 'MyMutableGlobalHL')
    end

    if
      token.type == 'class'
      --token.type == "variable"
      and token.modifiers.constructorOrDestructor
      --and not token.modifiers.readonly
    then
      --print(tprint(args.data))
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, 'function')
    end
  end,
})

vim.api.nvim_set_hl(0, 'MyMutableGlobalHL', { fg = '#6ab04c' })
vim.api.nvim_set_hl(0, 'DefaultClassType', { fg = '#009432' })
vim.api.nvim_set_hl(0, 'DefaultClassType', { fg = '#009432' })

vim.api.nvim_set_hl(0, 'FlashLabel', { bg = '#82ccdd', fg = '#000000', standout = true, bold = true })

vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#82ccdd' })

vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#82ccdd' })
-- vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#82ccdd' })

-- local map = require 'mini.map'
-- map.setup {
--   integrations = {
--     map.gen_integration.builtin_search(),
--     map.gen_integration.diff(),
--     map.gen_integration.diagnostic(),
--     map.gen_integration.gitsigns(),
--   },
-- }
