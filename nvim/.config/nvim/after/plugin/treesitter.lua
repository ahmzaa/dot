require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"vim",
		"vimdoc",
		"python",
		"go",
		"html",
		"css",
		"javascript",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"luadoc",
		"diff",
		"query",
	},

	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
})
