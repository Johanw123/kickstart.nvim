return {
  cmd = { 'shader-ls', '--stdio' },
  -- filetypes = { 'fx', 'hlsl', 'mgfxc' },
  -- root_dir = function(fname)
  --   return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
  -- end,
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
  single_file_support = true,
  capabilities = {},
}
