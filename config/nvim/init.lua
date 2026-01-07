-- NEOVIM OPTIONS
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

-- GENERAL KEYMAPS
vim.g.mapleader = " "

local keymap = vim.keymap
vim.opt.mouse = ""

keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Jump to previous file" })

-- Tabs
keymap.set("n", "<c-a>t", "<cmd>tabnew<CR>", { desc = "Create tab" })
keymap.set("n", "<c-a>x", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<c-a>n", "<cmd>tabnext<CR>", { desc = "Next tab" })
keymap.set("n", "<c-a>p", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Fugitive
keymap.set("n", "<C-g>s", "<cmd>Git<CR>", { desc = "Git status" })
keymap.set("n", "<C-g>a", "<cmd>Git add -p<CR>", { desc = "Git Add (interactive)" })
keymap.set("n", "<C-g>c", "<cmd>Git checkout -p<CR>", { desc = "Git Checkout (interactive)" })
keymap.set("n", "<C-g>bl", "<cmd>Git blame<CR>", { desc = "Git blame" })
keymap.set("n", "<C-g>u", "<cmd>Git commit --amend --no-edit<CR>", { desc = "Git ammend commit" })
keymap.set("n", "<C-g>g", "<cmd>GBrowse<CR>", { desc = "Open file on GitHub" })

local function bufferPath()
	local filepath = vim.fn.expand("%")
	vim.fn.setreg("+", filepath) -- write to clippoard
end
vim.keymap.set("n", "<leader>pc", bufferPath, { noremap = true, silent = true })

-- PLUGINS
vim.pack.add({
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/tpope/vim-surround" },
	{ src = "https://github.com/tpope/vim-repeat" },
	{ src = "https://github.com/tpope/vim-rhubarb" },
})

-- oil
vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim", name = "Oil" },
})
require("oil").setup({
	keymaps = {
		["<C-h>"] = false,
		["<C-l>"] = false,
		["<C-k>"] = false,
		["<C-j>"] = false,
	},
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
})

-- theme
vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" },
})
require("tokyonight").setup({

	style = "night",
})
vim.cmd([[colorscheme tokyonight]])

-- telescope
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
})

require("telescope").setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
			},
		},
		file_ignore_patterns = {
			"node_modules",
			"typescript",
		},
	},
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		bookmarks = {
			initial_mode = "normal",
		},
	},
})
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy file finder" })
vim.keymap.set("n", "\\", require("telescope.builtin").live_grep, { desc = "Search in project" })
vim.keymap.set("n", "<C-F>", "<cmd>Telescope grep_string<CR>", { desc = "Find word under cursor in project" })
vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" })
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show definitions" })
vim.keymap.set(
	"n",
	"gO",
	"<cmd>vsplit | Telescope lsp_definitions<CR>",
	{ desc = "Show definitions in vertical split" }
)
-- require("telescope").load_extension("fzf")

-- gitsigns
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git", name = "gitsigns" },
})
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		vim.keymap.set("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]h", bang = true })
			else
				gitsigns.nav_hunk("next", { wrap = "wrapscan" })
			end
		end, { desc = "Jump to next hunk", buffer = bufnr })
		vim.keymap.set("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[h", bang = true })
			else
				gitsigns.nav_hunk("prev", { wrap = "wrapscan" })
			end
		end, { desc = "Jump to previous hunk", buffer = bufnr })
		vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, { desc = "Stage hunk", buffer = bufnr })
	end,
})

-- vim-test
vim.pack.add({
	{ src = "https://github.com/vim-test/vim-test" },
})
vim.keymap.set("n", "<leader>f", "<cmd>TestFile<cr>", { desc = "Run test file" })
vim.keymap.set("n", "<leader>a", "<cmd>TestSuite<cr>", { desc = "Run test suite" })
vim.keymap.set("n", "<leader>l", "<cmd>TestLast<cr>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>s", "<cmd>TestNearest<cr>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>gt", "<cmd>TestVisit<cr>", { desc = "Visit test" })

-- sleuth
vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth" },
})

-- conform
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		lua = { "stylua" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		liquid = { "prettierd" },
		python = { "isort", "black" },
		ruby = { "rubocop" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

-- LSP PLUGINS
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"prettierd",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.pack.add({
	{ src = "https://github.com/pmizio/typescript-tools.nvim" },
})
require("typescript-tools").setup({
	settings = {
		tsserver_max_memory = 13112,
	},
})

-- Completion
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.8.0" },
})
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-Space>"] = { "show", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true },
		keyword = { range = "prefix" },
		list = { selection = { preselect = false, autoinsert = true } },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning", prebuilt_binaries = { force_version = "v1.8.0" } },
})
