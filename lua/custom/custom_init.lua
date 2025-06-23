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

if vim.fn.has 'win32' == 1 then
  vim.cmd 'language en_US'
end
--
vim.opt.diffopt = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram'

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.linespace = 5

--vim.o.winborder = 'rounded'

vim.g.mapleader = ' '

-- vim.diagnostic.config { virtual_text = true, virtual_lines = true }
-- vim.diagnostic.config { virtual_text = true, virtual_lines = false }
-- vim.diagnostic.config {
--   virtual_text = {
--     severity = {
--       max = vim.diagnostic.severity.WARN,
--     },
--   },
--   virtual_lines = {
--     severity = {
--       min = vim.diagnostic.severity.ERROR,
--     },
--   },
-- }
local diag_config1 = {
  virtual_text = {
    severity = {
      max = vim.diagnostic.severity.WARN,
    },
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
}
local diag_config2 = {
  virtual_text = true,
  virtual_lines = false,
}
vim.diagnostic.config(diag_config1)
local diag_config_basic = false
vim.keymap.set('n', 'gK', function()
  diag_config_basic = not diag_config_basic
  if diag_config_basic then
    vim.diagnostic.config(diag_config2)
  else
    vim.diagnostic.config(diag_config1)
  end
end, { desc = 'Toggle diagnostic virtual_lines' })

---[[AUTOCOMPLETION SETUP
vim.o.completeopt = 'menu,noinsert,popup,fuzzy,preview'

-- vim.g.indenltine_filetype_exclude = { 'help', 'dashboard', 'packer' }
--
--

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- -- Jump to the definition of the word under your cursor.
    -- --  This is where a variable was first declared, or where a function is defined, etc.
    -- --  To jump back, press <C-t>.
    -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    --
    -- -- Find references for the word under your cursor.
    -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    --
    -- -- Jump to the implementation of the word under your cursor.
    -- --  Useful when your language has ways of declaring types without an actual implementation.
    -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    --
    -- -- Jump to the type of the word under your cursor.
    -- --  Useful when you're not sure what type a variable is and you want to see
    -- --  the definition of its *type*, not where it was *defined*.
    -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    --
    -- -- Fuzzy find all the symbols in your current document.
    -- --  Symbols are things like variables, functions, types, etc.
    -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    --
    -- -- Fuzzy find all the symbols in your current workspace.
    -- --  Similar to document symbols, except searches over your entire project.
    -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- if client and client.server_capabilities.documentHighlightProvider then
    --   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    --     buffer = event.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.document_highlight,
    --   })

    --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    --     buffer = event.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end

    -- The following autocommand is used to enable inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code

    if client.name == 'clangd' then
      require('clangd_extensions').setup()
      -- require('clangd_extensions.inlay_hints').setup_autocmd()
      -- require('clangd_extensions.inlay_hints').set_inlay_hints()

      map('<leader>th', function()
        require('clangd_extensions.inlay_hints').toggle_inlay_hints()
      end, '[T]oggle Hints')
    else
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, '[T]oggle Hints')
      end
    end

    -- vim.keymap.set('n', '<leader>lt',
    --   function()
    --     if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    --       vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    --     end
    --   end, { desc = '[T]oggle Hints' })
  end,
})

--       vim.api.nvim_create_autocmd('LspDetach', {
--   group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
--   callback = function(event)
--     vim.lsp.buf.clear_references()
--     vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
--   end,
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method 'textDocument/completion' then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     ---[[Code required to activate autocompletion and trigger it on each keypress
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     --client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
--     vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
--       buffer = args.buf,
--       callback = function()
--         vim.lsp.completion.get()
--       end
--     })
--     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--     ---]]

--     ---[[Code required to add documentation popup for an item
--     local _, cancel_prev = nil, function() end
--     vim.api.nvim_create_autocmd('CompleteChanged', {
--       buffer = args.buf,
--       callback = function()
--         cancel_prev()
--         local info = vim.fn.complete_info({ 'selected' })
--         local completionItem = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
--         if nil == completionItem then
--           return
--         end
--         _, cancel_prev = vim.lsp.buf_request(args.buf,
--           vim.lsp.protocol.Methods.completionItem_resolve,
--           completionItem,
--           function(err, item, ctx)
--             if not item then
--               return
--             end
--             local docs = (item.documentation or {}).value
--             local win = vim.api.nvim__complete_set(info['selected'], { info = docs })
--             if win.winid and vim.api.nvim_win_is_valid(win.winid) then
--               vim.treesitter.start(win.bufnr, 'markdown')
--               vim.wo[win.winid].conceallevel = 3
--             end
--           end)
--       end
--     })
--     ---]]
--   end
-- })

--https://www.reddit.com/r/neovim/comments/1jkfpqg/are_there_still_benefits_for_using_lspconfig_in/
vim.lsp.enable { 'clangd', 'powershell_es', 'luals', 'glsl_analyzer' }

if vim.g.neovide then
  --vim.g.neovide_transparency = 0.9
  --vim.g.transparency = 0.9
  --vim.g.neovide_background_color = "#332C2A" .. alpha()
  --vim.g.neovide_background_color = "#332C2A"

  vim.o.guifont = 'FiraCode Nerd Font'

  vim.g.neovide_floating_blur_amount_x = 2
  vim.g.neovide_floating_blur_amount_y = 2

  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_cursor_animation_length = 0
end

vim.opt.shell = 'fish'

if vim.fn.has 'wsl' == 1 then
  package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
  package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'
  package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/magick/init.lua;'

  vim.opt.shell = 'fish'
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

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.xaml' },
  callback = function()
    vim.cmd.setfiletype 'xml'
  end,
})

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

-- set default off
--require('precognition').toggle()

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

require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    -- 'github:syndim/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
}

local ensure_installed = {
  clangd = {},
  cpptools = {},
  pyright = {},
  rust_analyzer = {},
  powershell_es = {},
  shellcheck = {},
  shellharden = {},
  zls = {},
  roslyn = {},
  glsl_analyzer = {},
}
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

vim.treesitter.language.register('glsl', { 'frag', 'vert' })

require 'custom.keybindings'
require 'custom.highlights'
