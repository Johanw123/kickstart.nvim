return {
    cmd = { 'glsl_analyzer' },
    filetypes = { 'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp', 'fx' },
    -- root_dir = function(fname)
    --   return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    -- end,
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
    single_file_support = true,
    capabilities = {},
  }
