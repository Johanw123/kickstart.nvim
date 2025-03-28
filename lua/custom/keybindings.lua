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

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

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
--vim.keymap.set('n', '<leader>cd', require('telescope').extensions.zoxide.list, { desc = '[C]hange [D]irectory' })
--vim.keymap.set("n", "<leader>fs", function() require('telescope.builtin').grep_string() end, {desc = "[F]ind [S]tring"})
-- vim.keymap.set("n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, {desc = "[F]ind [R]eferences"})
--vim.keymap.set('n', '<leader>sa', require('telescope').extensions.aerial.aerial, { desc = '[S]earch [A]erial' })

vim.keymap.set('n', '<Leader>pf', 'i<C-r><C-o>+<ESC>l=`[`]$', { desc = 'Paste block and indent' })

-- Precognition
-- vim.keymap.set('n', '<leader>p', 'lua require("precognition").peek()', { desc = 'Move focus to the upper window' })
--vim.keymap.set('n', '<leader>tp', '<cmd> lua require("precognition").toggle()<cr>', { desc = ' Toggle Precognition' })

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
  vim.fn.system { 'cmd', '/c', 'start', path, '\\explorer.exe' }
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

vim.keymap.set('n', '<leader>do', '<Cmd>DiffviewOpen<CR>', { desc = ' Diffview Open' })
vim.keymap.set('n', '<leader>dc', '<Cmd>DiffviewClose<CR>', { desc = ' Diffview Close' })
vim.keymap.set('n', '<leader>dt', '<Cmd>DiffviewToggleFiles<CR>', { desc = ' Diffview Toggle Files' })

-- Git
vim.keymap.set('n', '<leader>gp', function()
  require('vgit').project_diff_preview()
end, { desc = 'Project Diff Preview' })
vim.keymap.set('n', '<leader>gx', function()
  require('vgit').toggle_diff_preference()
end, { desc = 'Toggle Diff Mode' })
vim.keymap.set('n', '<leader>gu', function()
  require('vgit').buffer_reset()
end, { desc = 'Buffer Reset' })

vim.keymap.set('n', '<leader>gs', function()
  Snacks.picker.git_status()
end, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>go', function()
  Snacks.gitbrowse()
end, { desc = 'Git Open Browser' })

-- vim.keymap.set('n', '<leader>gl', function()
--   require('vgit').project_logs_preview()
-- end, { desc = 'Git Log' })

vim.keymap.set('n', '<leader>gl', function()
  Snacks.lazygit.log()
end, { desc = 'git log' })
vim.keymap.set('n', '<leader>gf', function()
  Snacks.lazygit.log_file()
end, { desc = 'Git Log File' })
vim.keymap.set('n', '<leader>gb', function()
  Snacks.git.blame_line()
end, { desc = 'Git Blame Line' })

vim.keymap.set('n', '<leader>gr', function()
  require('vgit').buffer_blame_preview()
end, { desc = 'Buffer Blame Preview' })
vim.keymap.set('n', '<leader>gj', function()
  require('vgit').buffer_diff_preview()
end, { desc = 'Buffer Diff Preview' })
vim.keymap.set('n', '<leader>gh', function()
  require('vgit').buffer_history_preview()
end, { desc = 'Buffer History Preview ' })

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
--require('precognition').toggle()