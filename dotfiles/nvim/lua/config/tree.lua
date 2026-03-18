vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Neotree<cr>", {})
require("neo-tree").setup({
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 180,
		number = true,
		relativenumber = true,
	},
})
