vim.g.mapleader = " "

local keymap = vim.keymap

-- Disable mouse
vim.opt.mouse = ""

keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Jump to previous file" })

keymap.set("n", "<leader>§", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file tree" })

keymap.set("n", "<c-a>t", "<cmd>tabnew<CR>", { desc = "Create tab" })
keymap.set("n", "<c-a>x", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<c-a>n", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap.set("n", "<c-a>p", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

keymap.set("n", "<C-g>s", "<cmd>Git<CR>", { desc = "Git status" })
keymap.set("n", "<C-g>a", "<cmd>Git add -p<CR>", { desc = "Git Add (interactive)" })
keymap.set("n", "<C-g>c", "<cmd>Git checkout -p<CR>", { desc = "Git Checkout (interactive)" })
keymap.set("n", "<C-g>bl", "<cmd>Git blame<CR>", { desc = "Git blame" })
keymap.set("n", "<C-g>u", "<cmd>Git commit --amend --no-edit<CR>", { desc = "Git ammend commit" })
keymap.set("n", "<C-g>g", "<cmd>GBrowse<CR>", { desc = "Open file on GitHub" })

local function bufferPath()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('+', filepath) -- write to clippoard
end

vim.keymap.set('n', '<leader>pc', bufferPath, { noremap = true, silent = true })
