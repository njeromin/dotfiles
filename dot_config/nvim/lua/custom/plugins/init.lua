return {
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls")
    end
  },

  ["andreadev-it/shade.nvim"] = {
    module = "shade",
    config = function()
        require("custom.plugins.smallconfigs").shade()
    end,
   },

  ["Pocco81/AutoSave.nvim"] = {
    module = "autosave",
    config = function()
      require("custom.plugins.smallconfigs").autosave()
    end,
  },
}

