return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    indent = {
      char = '│', -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
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
  },
}
