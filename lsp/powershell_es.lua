local bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
local command_fmt =
[[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal]]
local temp_path = vim.fn.stdpath("cache")
local command = command_fmt:format(bundle_path, bundle_path, temp_path, temp_path)

return {
  cmd = { "pwsh", "-NoLogo", "-Command", command },
  bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
  filetypes = { 'ps1' },
}
