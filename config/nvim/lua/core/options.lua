vim.o.termguicolors = true

local opt = vim.opt

opt.relativenumber = true
opt.number = true
-- centre cursor when scrolling
opt.scrolloff = 999

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ruler = true
opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true

opt.textwidth = 80
opt.colorcolumn = { 81 }
vim.cmd([[hi ColorColumn ctermbg=black guibg=black]])

-- Show weird spaces (and tabs)
opt.list = true
opt.listchars:append({
  tab = "»·",
  trail = "·",
  nbsp = "·",
})

-- Use Ag for search
opt.grepprg = "ag --no-group --nocolor"

-- Resize splits when tmux split changes
local wr_group = vim.api.nvim_create_augroup("WinResize", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
  group = wr_group,
  pattern = "*",
  command = "wincmd =",
  desc = "Automatically resize windows when the host window size changes.",
})
