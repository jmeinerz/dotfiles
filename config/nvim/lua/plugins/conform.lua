return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd", "prettier-plugin-organize-imports" },
        typescript = { "prettierd", "prettier-plugin-organize-imports" },
        javascriptreact = { "prettierd", "prettier-plugin-organize-imports" },
        typescriptreact = { "prettierd", "prettier-plugin-organize-imports" },
        svelte = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        liquid = { "prettierd" },
        python = { "isort", "black" },
        ruby = { "rubocop" }
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range" })
  end,
}
