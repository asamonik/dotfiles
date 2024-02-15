local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				border = "rounded",
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})
			vim.api.nvim_create_user_command("CargoRun", function()
				require("FTerm").scratch({ cmd = { "cargo", "run" } })
			end, { bang = true })
		end,
	},
	{
		"edluffy/hologram.nvim",
		config = function()
			require("hologram").setup({
				auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
			})
		end,
		rocks = { "magick" },
	},

	{
		"gaborvecsei/usage-tracker.nvim",
		config = function()
			require("usage-tracker").setup({
				keep_eventlog_days = 140,
				cleanup_freq_days = 7,
				event_wait_period_in_sec = 5,
				inactivity_threshold_in_min = 5,
				inactivity_check_freq_in_sec = 5,
				verbose = 0,
			})
		end,
	},

	{ "platformio/platformio-core" },
	{ "nvim-lua/plenary.nvim" },
	-- [[ Startup time ]]
	{ "dstein64/vim-startuptime" },

	-- [[ Platformio (for microcontroller programming) ]]
	{ "normen/vim-pio" },

	-- [[ Project plugin ]]
	{ "ahmedkhalf/project.nvim" },

	-- [[ VimTex Latex support]]
	{
		"lervag/vimtex",
		config = function()
			require("plugins.texlab")
		end,
	},

	-- [[ Screenshots ]]
	{ "asamonik/nvim-screenshot", build = "go build" },

	-- [[ CSS Color (Highlights colors in code) ]]
	{ "ap/vim-css-color" },

	{ "norcalli/nvim-colorizer.lua" },

	-- [[ Formatter ]]
	{
		"sbdchd/neoformat",
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				command = [[silent! undojoin | Neoformat]],
				desc = "Format using neoformat on save.",
				group = vim.api.nvim_create_augroup("neoformat_format_onsave", { clear = true }),
				pattern = "*",
			})
		end,
	},

	-- [[ LSP-server installer ]]
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },

	-- [[ LSP ]]
	{ "neovim/nvim-lspconfig" },
	{ "JuliaEditorSupport/julia-vim" },

	-- [[ Snippet engine ]]
	{ "L3MON4D3/LuaSnip" },

	-- [[ Completion ]]
	{
		"hrsh7th/nvim-cmp",
		event = "BufRead",
		dependencies = {
			"williamboman/mason.nvim",
			"LuaSnip",
			"nvim-lspconfig",
			"tzachar/cmp-ai",
		},
		config = function()
			require("plugins.cmp")
		end,
	},
	{ "hrsh7th/cmp-buffer", dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-path", dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-nvim-lua", dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "nvim-cmp" } },
	{ "saadparwaiz1/cmp_luasnip" },
	--[[
  {
  "tzachar/cmp-ai",
  config = function()
  local cmp_ai = require("cmp_ai.config")
  cmp_ai:setup({
  max_lines = 1000,
  provider = "OpenAI",
  model = "gpt-4",
  notify = true,
  build_on_every_keystroke = true,
  ignored_file_types = {
  -- default is not to ignore
  -- uncomment to ignore in lua:
  -- lua = true
  },
  })
  end,
  },
	--]]

	-- Comment
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({ comment_empty = false })
			local map = vim.keymap.set
			map("n", "gc", "<cmd>CommentToggle<CR>", { silent = true })
			map("v", "gc", ":<C-u>call CommentOperator(visualmode())<CR>", { silent = true })
		end,
	},

	-- [[ NPM ]]
	{
		"David-Kunz/cmp-npm",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("cmp-npm").setup({})
		end,
	},

	-- [[ Rust ]]
	{
		"simrat39/rust-tools.nvim",
		-- event = "BufRead",
		config = function()
			require("plugins.rust-tools")
		end,
	},

	{
		"saecki/crates.nvim",
		config = function()
			require("crates").setup()
		end,
	},

	-- [[ Treesitter ]]
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"HiPhish/nvim-ts-rainbow2",
		},
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},

	-- [[ NVIM Tree ]]
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				git = {
					enable = false,
				},
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})
		end,
	},

	-- [[ Theme ]]
	{
		"startup-nvim/startup.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("startup").setup()
		end,
	},

	-- [[ Shows animation on cursor jump ]]
	{ "DanilaMihailov/beacon.nvim" },

	-- [[ Bottom status line ]]
	{ "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons", lazy = true } },

	{
		"luisiacc/gruvbox-baby",
		lazy = false,
		priority = 1000,
		config = function()
			-- Style
			vim.g.gruvbox_baby_function_style = "NONE"
			vim.g.gruvbox_baby_keyword_style = "italic"

			-- Telescope theme
			vim.g.gruvbox_baby_telescope_theme = 1

			vim.g.gruvbox_baby_transparent_mode = 1
			vim.g.gruvbox_baby_use_original_palette = 1
			vim.cmd([[colorscheme gruvbox-baby]])
		end,
	},

	-- [[ Telescope (fuzzy finder and way more) ]]
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("plugins.telescope")
		end,
	},

	-- [[ Used for bottom tag bar ]]
	{ "majutsushi/tagbar" },

	-- [[ Shows nice bar each indent ]]
	{ "Yggdroot/indentLine" },

	-- [[ Git integration ]]
	{ "tpope/vim-fugitive" },

	-- [[ Commit history ]]
	{ "junegunn/gv.vim" },

	-- [[ Brackets pairing ]]
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- [[ Undo tree ]]
	{ "mbbill/undotree" },

	-- [[ Nerd Tree ]]
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("plugins.neotree")
		end,
	},
})
