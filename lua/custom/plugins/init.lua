-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

   {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
{
    'nvim-tree/nvim-tree.lua'
},

  -- Dap
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("custom.configs.dap")
        end,
    },

    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
        requires = { "mfussenegger/nvim-dap" },
    },

      -- C# stuff:

  {
    "OmniSharp/omnisharp-roslyn",
    lazy = false
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = false,
  },
  -- {
  --   "Decodetalkers/csharpls-extended-lsp.nvim",
  -- },
  -- {
  --   "OmniSharp/omnisharp-vim",
  --   lazy = false
  -- },
  {
    --Before trying to use the language server you should install it. You can do so by running :CSInstallRoslyn which will install the configured version of the plugin in neovim's datadir.
    "jmederosalvarado/roslyn.nvim",
  },
  -- {
  --   "razzmatazz/csharp-language-server"
  -- },
  -- C#

    {
        "NeogitOrg/neogit",
        dependencies = {
          "nvim-lua/plenary.nvim",         -- required
          "sindrets/diffview.nvim",        -- optional - Diff integration
    
          -- Only one of these is needed, not both.
          "nvim-telescope/telescope.nvim", -- optional
          "ibhagwan/fzf-lua",              -- optional
        },
        config = true,
        lazy = false
      },
      {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("oil").setup()
        end,
      },
      {
        'petertriho/nvim-scrollbar', 
        lazy = false,
        config = function()
          require("scrollbar").setup()
        end,
      },
      {
        "ThePrimeagen/harpoon"
      },
      {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
          require("better_escape").setup()
        end,
      },
    
      {
        "p00f/clangd_extensions.nvim",
      },
      {
        "HiPhish/rainbow-delimiters.nvim",
        --lazy = false,
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
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
      },
      {
        "karb94/neoscroll.nvim",
        lazy = false,
        config = function()
          require("neoscroll").setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
            hide_cursor = true, -- Hide cursor while scrolling
            stop_eof = true, -- Stop at <EOF> when scrolling downwards
            use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
            respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = 'quintic', -- Default easing function
            pre_hook = nil, -- Function to run before the scrolling animation starts
            post_hook = nil, -- Function to run after the scrolling animation ends
          })
        end,
      },
      {
        "folke/flash.nvim",
      },
      {
        "folke/trouble.nvim",
        config = function()
          return {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {
             -- your configuration comes here
             -- or leave it empty to use the default settings
             -- refer to the configuration section below
            },
           }
        end,
      },
    {
        "github/copilot.vim",
        lazy = false
    },
  {
   "tris203/precognition.nvim",
      --event = "VeryLazy",
      config = {
      -- startVisible = true,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
      },
    }
}
