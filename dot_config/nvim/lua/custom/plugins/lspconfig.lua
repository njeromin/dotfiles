local M = {}

M.setup_lsp = function (attach, capabilities)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = true,
    }
  )

  local lspconfig = require("lspconfig")
  local servers = require("nvim-lsp-installer.servers").get_installed_server_names()

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      on_attach = attach,
      capabilities = capabilities,
      root_dir = vim.loop.cwd,
    })
  end
end

return M
