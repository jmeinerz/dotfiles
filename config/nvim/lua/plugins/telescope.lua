return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          "typescript",
        }
      },
      extensions = {
        fzf = {}
      }
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy file finder" })
    keymap.set("n", "\\", builtin.live_grep, { desc = "Search in project" })
    keymap.set("n", "<C-F>", "<cmd>Telescope grep_string<CR>", { desc = "Find word under cursor in project" })
  end
}
