require("which-key").setup({
	delay = 0,
	spec = {},
})

local wk = require("which-key")
wk.add({
	{ "<leader>f", group = "[F]ind" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>y", group = "[Y]ank to Sys Clipboard", mode = { "n", "v" } },
	{ "<leader>Y", group = "[Y]ank to Sys Clipboard", mode = { "n", "v" } },
	{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
})
