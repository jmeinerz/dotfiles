return {
  "vim-test/vim-test",
  config = function()
    local keymap = vim.keymap

    keymap.set("n", "<leader>f", "<cmd>TestFile<cr>", { desc = "Run test file" })
    keymap.set("n", "<leader>a", "<cmd>TestSuite<cr>", { desc = "Run test suite" })
    keymap.set("n", "<leader>l", "<cmd>TestLast<cr>", { desc = "Run last test" })
    keymap.set("n", "<leader>s", "<cmd>TestNearest<cr>", { desc = "Run nearest test" })
    keymap.set("n", "<leader>gt", "<cmd>TestVisit<cr>", { desc = "Visit test" })
  end,
}
