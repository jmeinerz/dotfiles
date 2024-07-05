return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        "diff",
        "markdown",
        "graphql",
        "javascript",
        "json",
        "lua",
        "typescript",
        "luadoc",
        "vim",
        "vimdoc",
        "ruby",
      },
    })
  end,
}
