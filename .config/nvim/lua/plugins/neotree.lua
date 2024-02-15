-- [[ Prefix: N ]]
vim.keymap.set(
	"n",
	"<leader>nn",
	"<cmd>Neotree toggle right<cr>",
	{ noremap = true, silent = true, desc = "Toggle Neo-tree filesystem" }
)
vim.keymap.set(
	"n",
	"<leader>nb",
	"<cmd>Neotree toggle buffers float<cr>",
	{ noremap = true, silent = true, desc = "Toggle Neo-tree buffers" }
)
vim.keymap.set(
	"n",
	"<leader>ng",
	"<cmd>Neotree toggle git_status float<cr>",
	{ noremap = true, silent = true, desc = "Toggle Neo-tree git-status" }
)
vim.keymap.set(
	"n",
	"<leader>nd",
	"<cmd>Neotree toggle diagnostics float<cr>",
	{ noremap = true, silent = true, desc = "Toggle Neo-tree diagnostics" }
)
vim.keymap.set(
	"n",
	"<leader>nr",
	"<cmd>Neotree reveal<cr>",
	{ noremap = true, silent = true, desc = "Reveal Neo-tree" }
)
