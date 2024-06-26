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

opt.linespace = 5

vim.g.mapleader = " "

if vim.g.neovide then
	--vim.g.neovide_transparency = 0.9
	--vim.g.transparency = 0.9
	--vim.g.neovide_background_color = "#332C2A" .. alpha()
	--vim.g.neovide_background_color = "#332C2A"

	vim.o.guifont = "FiraCode NF"

	vim.g.neovide_floating_blur_amount_x = 2
	vim.g.neovide_floating_blur_amount_y = 2

	vim.g.neovide_refresh_rate = 165
	vim.g.neovide_cursor_animation_length = 0
end

if vim.fn.has("wsl") == 1 then
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/magick/init.lua;"

  -- vim.opt.shell = "kitty"
  -- vim.opt.shellcmdflag = "--detach"
  vim.opt.shell = "zsh"
elseif vim.fn.has('win32') == 1 and vim.fn.has("wsl") == 0 then
	local powershell_options = {
		shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}

	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end

  package.path = package.path .. ";" .. vim.fn.expand("$APPDATA") .. "\\LuaRocks\\share\\lua\\5.1\\?\\init.lua;"
  package.path = package.path .. ";" .. vim.fn.expand("$APPDATA") .. "\\LuaRocks\\share\\lua\\5.1\\?.lua;"

  local avalonia_lsp_bin = "C:\\Users\\johanw\\.vscode\\extensions\\avaloniateam.vscode-avalonia-0.0.31\\avaloniaServer\\AvaloniaLanguageServer.dll"

  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"},{ pattern = {"*.axaml"}, callback =
    function()
      vim.cmd.setfiletype("xml")
      vim.lsp.start({
        name = "Avalonia LSP",
        cmd = { "dotnet", avalonia_lsp_bin },
        root_dir = vim.fn.getcwd(),
      })
    end})
end

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
  
  require("ibl").setup { indent = { highlight = highlight, char = "│" } }



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
  vim.keymap.set('n', '<leader>fj', function() require("flash").jump() end, { desc = 'Flash [J]ump' })
  vim.keymap.set('n', '<leader>ft', function() require("flash").treesitter() end, { desc = 'Flash Treesitter' })
  vim.keymap.set('n', '<leader>fr', function() require("flash").treesitter_search() end, { desc = 'Flash Treesitter Search' })

  -- Buffer
  vim.keymap.set('n', '<leader>bf', function() require('conform').format { async = true, lsp_fallback = true } end, { desc = '[F]ormat buffer' })

  -- LSP
  vim.keymap.set('n', '<leader>lh', function() vim.lsp.buf.signature_help() end, { desc = '[H]elp' })


  -- Telescope
  vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list, {desc = "[C]hange [D]irectory"})
  --vim.keymap.set("n", "<leader>fs", function() require('telescope.builtin').grep_string() end, {desc = "[F]ind [S]tring"})
 -- vim.keymap.set("n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, {desc = "[F]ind [R]eferences"})



  vim.keymap.set('n', '<Leader>pf', 'i<C-r><C-o>+<ESC>l=`[`]$', { desc = 'Paste block and indent'})


-- Precognition
  -- vim.keymap.set('n', '<leader>p', 'lua require("precognition").peek()', { desc = 'Move focus to the upper window' })
  vim.keymap.set('n', '<leader>tp', '<cmd> lua require("precognition").toggle()<cr>', { desc = 'Toggle Precognition' })

  -- Set keymap for <leader>tt to run !start powershell and cmd to the current working directory
  vim.keymap.set("n", "<leader>tt", function()
      -- get cwd and run cmd
      local cwd = vim.fn.getcwd()
      vim.fn.system { 'cmd', '/c','start', 'pwsh', '-NoExit'}
      end, { noremap = true, silent = true, desc = "Start powershell" 
  })

  -- vim.keymap.set('n', '<leader>lt', 
  --   function()      
  --     if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
  --       vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  --     end
  --   end, { desc = '[T]oggle Hints' })

  vim.keymap.set('n', '<leader>o',
  function()
    local path = vim.fn.fnamemodify(vim.fn.expand("%:h"), ":p")
    vim.fn.system { 'cmd', '/c', 'explorer', path }
  end, { desc = 'Explore file location' }) 

  -- require('which-key').register {
  --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  --   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  --   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  --   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  -- }

  require('which-key').register {
    ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
    ['<leader>f'] = { name = '[F]lash', _ = 'which_key_ignore' },
    ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
    ['<leader>l'] = { name = '[L]sp', _ = 'which_key_ignore' },
  }





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
    require("precognition").toggle()