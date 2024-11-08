-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
      {
        '<leader>cR',
        function()
          Snacks.rename()
        end,
        desc = 'Rename File',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
          Snacks.toggle.diagnostics():map '<leader>td'
          Snacks.toggle.line_number():map '<leader>tl'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
          Snacks.toggle.treesitter():map '<leader>tT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>tb'
          --Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
    end,
  },

  {
    'nvim-tree/nvim-web-devicons',
    enabled = true,
  },
  {
    'nvim-tree/nvim-tree.lua',
  },

  {
    'mechatroner/rainbow_csv',
  },

  -- Dap
  -- {
  --   'mfussenegger/nvim-dap',
  --   config = function()
  --     require 'custom.configs.dap'
  --   end,
  -- },

  -- { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end,
    requires = { 'mfussenegger/nvim-dap' },
  },

  {
    'Hoffs/omnisharp-extended-lsp.nvim',
  },

  -- {
  --   --Before trying to use the language server you should install it. You can do so by running :CSInstallRoslyn which will install the configured version of the plugin in neovim's datadir.
  --   'jmederosalvarado/roslyn.nvim',
  -- },
  {
    'seblj/roslyn.nvim',
    ft = 'cs',
    opts = {
      config = {
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      },
      exe = {
        'dotnet',
        vim.fs.joinpath(vim.fn.stdpath 'data', 'roslyn', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
      },
    },
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
    },
    config = true,
    lazy = true,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
    end,
  },

  -- {
  --   'petertriho/nvim-scrollbar',
  --   lazy = false,
  --   config = function()
  --     require('scrollbar').setup()
  --   end,
  -- },
  --

  {
    'stevearc/aerial.nvim',
    lazy = true,
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'lewis6991/satellite.nvim',
  },
  -- {
  --   'gorbit99/codewindow.nvim',
  --   config = function()
  --     local codewindow = require 'codewindow'
  --     codewindow.setup()
  --     codewindow.apply_default_keybinds()
  --   end,
  -- },
  -- { 'echasnovski/mini.map', version = false },

  -- ---@module "neominimap.config.meta"
  -- {
  --   'Isrothy/neominimap.nvim',
  --   version = 'v3.*.*',
  --   enabled = true,
  --   lazy = false, -- NOTE: NO NEED to Lazy load
  --   -- Optional
  --   keys = {
  --     -- Global Minimap Controls
  --     { '<leader>nm', '<cmd>Neominimap toggle<cr>', desc = 'Toggle global minimap' },
  --     { '<leader>no', '<cmd>Neominimap on<cr>', desc = 'Enable global minimap' },
  --     { '<leader>nc', '<cmd>Neominimap off<cr>', desc = 'Disable global minimap' },
  --     { '<leader>nr', '<cmd>Neominimap refresh<cr>', desc = 'Refresh global minimap' },
  --
  --     -- Window-Specific Minimap Controls
  --     { '<leader>nwt', '<cmd>Neominimap winToggle<cr>', desc = 'Toggle minimap for current window' },
  --     { '<leader>nwr', '<cmd>Neominimap winRefresh<cr>', desc = 'Refresh minimap for current window' },
  --     { '<leader>nwo', '<cmd>Neominimap winOn<cr>', desc = 'Enable minimap for current window' },
  --     { '<leader>nwc', '<cmd>Neominimap winOff<cr>', desc = 'Disable minimap for current window' },
  --
  --     -- Tab-Specific Minimap Controls
  --     { '<leader>ntt', '<cmd>Neominimap tabToggle<cr>', desc = 'Toggle minimap for current tab' },
  --     { '<leader>ntr', '<cmd>Neominimap tabRefresh<cr>', desc = 'Refresh minimap for current tab' },
  --     { '<leader>nto', '<cmd>Neominimap tabOn<cr>', desc = 'Enable minimap for current tab' },
  --     { '<leader>ntc', '<cmd>Neominimap tabOff<cr>', desc = 'Disable minimap for current tab' },
  --
  --     -- Buffer-Specific Minimap Controls
  --     { '<leader>nbt', '<cmd>Neominimap bufToggle<cr>', desc = 'Toggle minimap for current buffer' },
  --     { '<leader>nbr', '<cmd>Neominimap bufRefresh<cr>', desc = 'Refresh minimap for current buffer' },
  --     { '<leader>nbo', '<cmd>Neominimap bufOn<cr>', desc = 'Enable minimap for current buffer' },
  --     { '<leader>nbc', '<cmd>Neominimap bufOff<cr>', desc = 'Disable minimap for current buffer' },
  --
  --     ---Focus Controls
  --     { '<leader>nf', '<cmd>Neominimap focus<cr>', desc = 'Focus on minimap' },
  --     { '<leader>nu', '<cmd>Neominimap unfocus<cr>', desc = 'Unfocus minimap' },
  --     { '<leader>ns', '<cmd>Neominimap toggleFocus<cr>', desc = 'Switch focus on minimap' },
  --   },
  --   init = function()
  --     -- The following options are recommended when layout == "float"
  --     vim.opt.wrap = false
  --     vim.opt.sidescrolloff = 36 -- Set a large value
  --
  --     --- Put your configuration here
  --     ---@type Neominimap.UserConfig
  --     vim.g.neominimap = {
  --       auto_enable = true,
  --       x_multiplier = 4,
  --       y_multiplier = 1,
  --       layout = 'float',
  --       float = {
  --         z_index = 10,
  --         window_border = 'single',
  --         margin = {
  --           right = 4,
  --         },
  --       },
  --       win_filter = function(winid)
  --         return winid == vim.api.nvim_get_current_win()
  --       end,
  --     }
  --   end,
  -- },

  {
    'ThePrimeagen/harpoon',
  },
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'p00f/clangd_extensions.nvim',
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = false,
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          --'RainbowDelimiterRed',
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        -- whitelist = {'c', 'cpp', 'cs'},
      }
    end,
  },
  -- {
  --   'karb94/neoscroll.nvim',
  --   lazy = false,
  --   config = function()
  --     require('neoscroll').setup {
  --       -- All these keys will be mapped to their corresponding default scrolling animation
  --       mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
  --       hide_cursor = true, -- Hide cursor while scrolling
  --       stop_eof = true, -- Stop at <EOF> when scrolling downwards
  --       use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  --       respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  --       cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
  --       easing_function = 'quintic', -- Default easing function
  --       pre_hook = nil, -- Function to run before the scrolling animation starts
  --       post_hook = nil, -- Function to run after the scrolling animation ends
  --     }
  --   end,
  -- },
  {
    'folke/flash.nvim',
  },
  {
    'folke/trouble.nvim',
    config = function()
      return {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        },
      }
    end,
  },
  {
    'github/copilot.vim',
    -- lazy = false
  },

  {
    'onsails/lspkind.nvim',
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },

  {
    'k-takata/vim-nsis',
  },

  {
    'sindrets/diffview.nvim',
  },

  -- {
  --   'tris203/precognition.nvim',
  --   --event = "VeryLazy",
  --   config = {
  --     -- startVisible = true,
  --     -- showBlankVirtLine = true,
  --     -- highlightColor = { link = "Comment" },
  --     -- hints = {
  --     --      Caret = { text = "^", prio = 2 },
  --     --      Dollar = { text = "$", prio = 1 },
  --     --      MatchingPair = { text = "%", prio = 5 },
  --     --      Zero = { text = "0", prio = 1 },
  --     --      w = { text = "w", prio = 10 },
  --     --      b = { text = "b", prio = 9 },
  --     --      e = { text = "e", prio = 8 },
  --     --      W = { text = "W", prio = 7 },
  --     --      B = { text = "B", prio = 6 },
  --     --      E = { text = "E", prio = 5 },
  --     -- },
  --     -- gutterHints = {
  --     --     G = { text = "G", prio = 10 },
  --     --     gg = { text = "gg", prio = 9 },
  --     --     PrevParagraph = { text = "{", prio = 8 },
  --     --     NextParagraph = { text = "}", prio = 8 },
  --     -- },
  --   },
  -- },
  {
    'Johanw123/avalonia.nvim',
    -- config = function()
    --   require('avalonia').setup {
    --     openUrlCommand = nil, -- start/open/xdg-open
    --     forced_browser = nil, -- firefox/chrome/msedge etc
    --     displayMethod = 'html', -- html/kitty(not implemented yet)
    --     tcp_port = 27016, -- port for connecting to avalonia preview rendering process, leave as 0 to let OS decide
    --     debug = true,
    --   }
    -- end,
  },

  {
    'aznhe21/actions-preview.nvim',
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  {
    'nvchad/ui',
    config = function()
      require 'nvchad'
    end,
  },
  {
    'nvchad/base46',
    lazy = true,
    build = function()
      require('base46').load_all_highlights()
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    --dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },

  { 'NvChad/nvim-colorizer.lua' },
}
