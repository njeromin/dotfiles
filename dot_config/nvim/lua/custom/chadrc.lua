local M = {}

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf= "custom.plugins.lspconfig"
    }
  }
}

M.mappings = {
  general = {
    n = {
      ["<C-x>"] = { "<cmd> qa <CR>", "  exit" },
    }
  }
}

return M
