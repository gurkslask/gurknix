vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", {})
require("neo-tree").setup({
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 40,
		number = true,
		relativenumber = true,
	},
})
