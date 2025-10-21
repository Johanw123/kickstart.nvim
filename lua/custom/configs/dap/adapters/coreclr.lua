local M = {}

M.adapter = {
  type = 'executable',
  --command = '/usr/local/bin/netcoredbg/netcoredbg',
  command = '/usr/bin/netcoredbg',
  name = 'coreclr',
  args = { '--interpreter=vscode' },
}

M.config = {
  {
    type = 'coreclr',
    name = 'launch - netcoredbg',
    request = 'launch',
    -- program = function()
    --   return vim.fn.input('Path to dll:', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    -- end,
  },
}

return M
