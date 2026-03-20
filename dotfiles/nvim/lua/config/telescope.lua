local telescope = require("telescope")
local builtin = require("telescope.builtin")
local wk = require("which-key")

telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				width = 0.9,
			},
		},
	},
})

telescope.load_extension("file_browser")

-- wk.register({
	-- T = { builtin.builtin, "Telescope - find picker" },
	-- f = {
		-- name = "Telescope",
		-- f = { builtin.find_files, "Find file" },
		-- g = { builtin.live_grep, "Live grep" },
		-- b = { builtin.buffers, "Buffers" },
		-- h = { builtin.help_tags, "Help tags" },
		-- t = { builtin.treesitter, "Treesitter" },
		-- r = { builtin.lsp_references, "References" },
		-- c = { builtin.commands, "Commands" },
		-- e = { telescope.extensions.file_browser.file_browser, "File browser" },
	-- },
-- }, { prefix = "<leader>" })
wk.add({
  { "<leader>T", builtin.builtin, desc = "Telescope - find picker" },
  { "<leader>f", group = "Telescope" }, -- Definierar gruppen
  { "<leader>ff", builtin.find_files, desc = "Find file" },
  { "<leader>fg", builtin.live_grep, desc = "Live grep" },
  { "<leader>fb", builtin.buffers, desc = "Buffers" },
  { "<leader>fh", builtin.help_tags, desc = "Help tags" },
  { "<leader>ft", builtin.treesitter, desc = "Treesitter" },
  { "<leader>fr", builtin.lsp_references, desc = "References" },
  { "<leader>fc", builtin.commands, desc = "Commands" },
  { "<leader>fe", function() require('telescope').extensions.file_browser.file_browser() end, desc = "File browser" },
})

local ok, yaml_companion = pcall(require, "yaml-companion")
if ok then
	wk.register({
		f = {
			y = { yaml_companion.open_ui_select, "YAML schema" },
		},
	}, { prefix = "<leader>" })
end
