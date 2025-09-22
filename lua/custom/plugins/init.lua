-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
local function ternary(cond, T, F)
  if cond then
    return T
  else
    return F
  end
end

return {
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- },
  --
  --
  -- Lua
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      -- notifier = {
      --   enabled = true,
      --   timeout = 3000,
      -- },
      --scroll = { enabled = true },
      image = { enabled = true, force = true },
      dashboard = {
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      explorer = { enabled = true },
      picker = {},
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        '<C-n>',
        function()
          Snacks.picker.explorer()
        end,
      },
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

      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
        desc = 'Files',
      },

      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },

      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Word',
        mode = { 'n', 'x' },
      },

      {
        '<leader>sb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },

      -- {
      --   '<leader>sg',
      --   function()
      --     Snacks.picker.git_files()
      --   end,
      --   desc = 'Git Files',
      -- },

      {
        '<leader>sl',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Lines',
      },
      {
        '<leader><leader>',
        function()
          Snacks.picker.pick { finder = 'smart', finders = { 'buffers', 'recent', 'files' } }
        end,
      },

      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
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
    lazy = true,
    enabled = true,
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
  },

  {
    'mechatroner/rainbow_csv',
    lazy = true,
  },

  {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup {
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
        -- be specified
      }
    end,
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
    lazy = true,
  },

  {
    'miroshQa/debugmaster.nvim',
    config = function()
      local dm = require 'debugmaster'
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      vim.keymap.set({ 'n', 'v' }, '<leader>dd', dm.mode.toggle, { nowait = true })
      vim.keymap.set('t', '<C-/>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    end,
  },

  {
    'Hoffs/omnisharp-extended-lsp.nvim',
  },

  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
      -- NOTE: You must configure `cmd` in `config.cmd` unless you have installed via mason
    },
  },

  -- {
  --   'GustavEikaas/easy-dotnet.nvim',
  --   config = function()
  --     require('easy-dotnet').setup()
  --   end,
  -- },

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
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      -- OR 'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end,
  },
  {
    'stevearc/oil.nvim',
    -- lazy = true,
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      }
    end,
  },

  {
    'stevearc/aerial.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
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
  {
    'ThePrimeagen/harpoon',
    lazy = true,
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
    lazy = true,
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
    lazy = true,
  },
  {
    'folke/trouble.nvim',
    optional = true,
    specs = {
      'folke/snacks.nvim',
      opts = function(_, opts)
        return vim.tbl_deep_extend('force', opts or {}, {
          picker = {
            actions = require('trouble.sources.snacks').actions,
            win = {
              input = {
                keys = {
                  ['<c-t>'] = {
                    'trouble_open',
                    mode = { 'n', 'i' },
                  },
                },
              },
            },
          },
        })
      end,
    },
  },

  {
    'onsails/lspkind.nvim',
    lazy = true,
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
    lazy = false,
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
    lazy = true,
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
    lazy = true,
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
    lazy = true,
    opts = {},
    --dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },

  -- {
  --   'nvimdev/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require('dashboard').setup {
  --       theme = 'hyper',
  --       config = {
  --         week_header = {
  --           enable = true,
  --         },
  --         shortcut = {
  --           { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
  --           {
  --             icon = ' ',
  --             icon_hl = '@variable',
  --             desc = 'Files',
  --             group = 'Label',
  --             action = 'Telescope find_files',
  --             key = 'f',
  --           },
  --           {
  --             desc = ' Apps',
  --             group = 'DiagnosticHint',
  --             action = 'Telescope app',
  --             key = 'a',
  --           },
  --           {
  --             desc = ' dotfiles',
  --             group = 'Number',
  --             action = 'Telescope dotfiles',
  --             key = 'd',
  --           },
  --         },
  --       },
  --     }
  --   end,
  --   dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  -- },

  { 'NvChad/nvim-colorizer.lua' },

  -- https://www.reddit.com/r/neovim/comments/10nfhqa/is_there_a_way_to_show_side_by_side_diffs_when/
  {
    'tanvirtin/vgit.nvim',
    branch = 'v1.0.x',
    -- or               , tag = 'v1.0.2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = 'VimEnter',
    config = function()
      require('vgit').setup {
        settings = {
          scene = {
            diff_preference = 'split',
          },
        },
      }
    end,
  },

  {
    'timtro/glslView-nvim',
    ft = 'glsl',
    config = function()
      require('glslView').setup {
        viewer_path = 'glslViewer',
        args = { '-l' },
      }
    end,
  },

  {
    'williamboman/mason.nvim',
    config = true,
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      --{ 'folke/neodev.nvim', opts = {} },
    },
  },

  {
    'github/copilot.vim',
    -- cmd = "Copilot",
    -- event = "BufWinEnter",
    -- init = function()
    --   vim.g.copilot_no_maps = true
    -- end,
    -- config = function()
    --   -- Block the normal Copilot suggestions
    --   vim.api.nvim_create_augroup("github_copilot", { clear = true })
    --   vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
    --     group = "github_copilot",
    --     callback = function(args)
    --       vim.fn["copilot#On" .. args.event]()
    --     end,
    --   })
    --   vim.fn["copilot#OnFileType"]()
    -- end,
  },

  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'mikavilpas/blink-ripgrep.nvim',
      'folke/snacks.nvim',
      'fang2hou/blink-copilot',
      'Kaiser-Yang/blink-cmp-avante',
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'enter' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        -- { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }
        documentation = { auto_show = true },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          -- 👇🏻👇🏻 add the ripgrep provider config below
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            -- -- the options below are optional, some default values are shown
            -- ---@module "blink-ripgrep"
            -- ---@type blink-ripgrep.Options
            -- opts = {
            --   -- For many options, see `rg --help` for an exact description of
            --   -- the values that ripgrep expects.

            --   -- the minimum length of the current word to start searching
            --   -- (if the word is shorter than this, the search will not start)
            --   prefix_min_len = 3,

            --   -- The number of lines to show around each match in the preview
            --   -- (documentation) window. For example, 5 means to show 5 lines
            --   -- before, then the match, and another 5 lines after the match.
            --   context_size = 5,

            --   -- The maximum file size of a file that ripgrep should include in
            --   -- its search. Useful when your project contains large files that
            --   -- might cause performance issues.
            --   -- Examples:
            --   -- "1024" (bytes by default), "200K", "1M", "1G", which will
            --   -- exclude files larger than that size.
            --   max_filesize = "1M",

            --   -- Specifies how to find the root of the project where the ripgrep
            --   -- search will start from. Accepts the same options as the marker
            --   -- given to `:h vim.fs.root()` which offers many possibilities for
            --   -- configuration. If none can be found, defaults to Neovim's cwd.
            --   --
            --   -- Examples:
            --   -- - ".git" (default)
            --   -- - { ".git", "package.json", ".root" }
            --   project_root_marker = ".git,.ignore",

            --   -- Enable fallback to neovim cwd if project_root_marker is not
            --   -- found. Default: `true`, which means to use the cwd.
            --   project_root_fallback = true,

            --   -- The casing to use for the search in a format that ripgrep
            --   -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
            --   -- available options ripgrep supports, but you can try
            --   -- "--case-sensitive" or "--smart-case".
            --   search_casing = "--ignore-case",

            --   -- (advanced) Any additional options you want to give to ripgrep.
            --   -- See `rg -h` for a list of all available options. Might be
            --   -- helpful in adjusting performance in specific situations.
            --   -- If you have an idea for a default, please open an issue!
            --   --
            --   -- Not everything will work (obviously).
            --   additional_rg_options = {},

            --   -- When a result is found for a file whose filetype does not have a
            --   -- treesitter parser installed, fall back to regex based highlighting
            --   -- that is bundled in Neovim.
            --   fallback_to_regex_highlighting = true,

            --   -- Absolute root paths where the rg command will not be executed.
            --   -- Usually you want to exclude paths using gitignore files or
            --   -- ripgrep specific ignore files, but this can be used to only
            --   -- ignore the paths in blink-ripgrep.nvim, maintaining the ability
            --   -- to use ripgrep for those paths on the command line. If you need
            --   -- to find out where the searches are executed, enable `debug` and
            --   -- look at `:messages`.
            --   ignore_paths = {},

            --   -- Any additional paths to search in, in addition to the project
            --   -- root. This can be useful if you want to include dictionary files
            --   -- (/usr/share/dict/words), framework documentation, or any other
            --   -- reference material that is not available within the project
            --   -- root.
            --   additional_paths = {},

            --   -- Features that are not yet stable and might change in the future.
            --   -- You can enable these to try them out beforehand, but be aware
            --   -- that they might change. Nothing is enabled by default.
            --   future_features = {
            --     -- Keymaps to toggle features on/off. This can be used to alter
            --     -- the behavior of the plugin without restarting Neovim. Nothing
            --     -- is enabled by default.
            --     toggles = {
            --       -- The keymap to toggle the plugin on and off from blink
            --       -- completion results. Example: "<leader>tg"
            --       on_off = "<leader>tg",
            --     },

            --     -- The backend to use for searching. Defaults to "ripgrep".
            --     -- Available options:
            --     -- - "ripgrep", always use ripgrep
            --     -- - "gitgrep", always use git grep
            --     -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise ripgrep
            --     backend = "gitgrep-or-ripgrep",
            --   },

            --   -- Show debug information in `:messages` that can help in
            --   -- diagnosing issues with the plugin.
            --   debug = true,
            -- },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = '(rg)',
                }
              end
              return items
            end,
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            },
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },

      keymap = {
        -- 👇🏻👇🏻 (optional) add a keymap to invoke the search manually
        ['<c-r>'] = {
          function()
            require('blink-cmp').show { providers = { 'ripgrep' } }
          end,
        },
        ['<c-g>'] = {
          function()
            require('blink-cmp').show { providers = { 'copilot' } }
          end,
        },

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },

  {

    'xzbdmw/colorful-menu.nvim',
    config = function()
      -- You don't need to set these options.
      require('colorful-menu').setup {
        ls = {
          lua_ls = {
            -- Maybe you want to dim arguments a bit.
            arguments_hl = '@comment',
          },
          gopls = {
            -- By default, we render variable/function's type in the right most side,
            -- to make them not to crowd together with the original label.

            -- when true:
            -- foo             *Foo
            -- ast         "go/ast"

            -- when false:
            -- foo *Foo
            -- ast "go/ast"
            align_type_to_right = true,
            -- When true, label for field and variable will format like "foo: Foo"
            -- instead of go's original syntax "foo Foo". If align_type_to_right is
            -- true, this option has no effect.
            add_colon_before_type = false,
            -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
            preserve_type_when_truncate = true,
          },
          -- for lsp_config or typescript-tools
          ts_ls = {
            -- false means do not include any extra info,
            -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
            extra_info_hl = '@comment',
          },
          vtsls = {
            -- false means do not include any extra info,
            -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
            extra_info_hl = '@comment',
          },
          ['rust-analyzer'] = {
            -- Such as (as Iterator), (use std::io).
            extra_info_hl = '@comment',
            -- Similar to the same setting of gopls.
            align_type_to_right = true,
            -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
            preserve_type_when_truncate = true,
          },
          clangd = {
            -- Such as "From <stdio.h>".
            extra_info_hl = '@comment',
            -- Similar to the same setting of gopls.
            align_type_to_right = true,
            -- the hl group of leading dot of "•std::filesystem::permissions(..)"
            import_dot_hl = '@comment',
            -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
            preserve_type_when_truncate = true,
          },
          zls = {
            -- Similar to the same setting of gopls.
            align_type_to_right = true,
          },
          roslyn = {
            extra_info_hl = '@comment',
          },
          dartls = {
            extra_info_hl = '@comment',
          },
          -- The same applies to pyright/pylance
          basedpyright = {
            -- It is usually import path such as "os"
            extra_info_hl = '@comment',
          },
          -- If true, try to highlight "not supported" languages.
          fallback = true,
          -- this will be applied to label description for unsupport languages
          fallback_extra_info_hl = '@comment',
        },
        -- If the built-in logic fails to find a suitable highlight group for a label,
        -- this highlight is applied to the label.
        fallback_highlight = '@variable',
        -- If provided, the plugin truncates the final displayed text to
        -- this width (measured in display cells). Any highlights that extend
        -- beyond the truncation point are ignored. When set to a float
        -- between 0 and 1, it'll be treated as percentage of the width of
        -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
        -- Default 60.
        max_width = 60,
      }
    end,
  },

  -- {
  --   'ravitemer/mcphub.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
  --   config = function()
  --     require('mcphub').setup()
  --   end,
  -- },

  { --https://composio.dev/blog/how-to-transform-your-neovim-to-cursor-in-minutes
    'yetone/avante.nvim',
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has 'win32' == 1 then
        return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      else
        return 'make'
      end
    end,
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'ollama',
      providers = {
        ollama = {
          endpoint = 'http://127.0.0.1:11434', -- Note that there is no /v1 at the end.
          model = 'qwen2.5-coder:14b',
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'stevearc/dressing.nvim', -- for input provider dressing
      'folke/snacks.nvim', -- for input provider snacks
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    -- config = function()
    --   require('avante').setup {
    --     -- system_prompt as function ensures LLM always has latest MCP server state
    --     -- This is evaluated for every message, even in existing chats
    --     system_prompt = function()
    --       local hub = require('mcphub').get_hub_instance()
    --       return hub and hub:get_active_servers_prompt() or ''
    --     end,
    --     -- Using function prevents requiring mcphub before it's loaded
    --     custom_tools = function()
    --       return {
    --         require('mcphub.extensions.avante').mcp_tool(),
    --       }
    --     end,
    --   }
    -- end,
    --
  {
      "soemre/commentless.nvim",
      cmd = "Commentless",
      keys = {
          {
              "<leader>/",
              function()
                  require("commentless").toggle()
              end,
              desc = "Toggle Comments",
          },
      },
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
      },
      opts = {
        hide_following_blank_lines = true,
        foldtext = function(folded_count)
            return "(" .. folded_count .. " comments)"
        end,
      },
  },
  },
}
