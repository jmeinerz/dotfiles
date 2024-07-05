return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {},
      renderer = {
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            folder = {},
          },
        },
      },
      actions = {},
    })
  end
}
