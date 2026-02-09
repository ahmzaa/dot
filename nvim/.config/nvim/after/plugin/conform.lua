local conform = require("conform")

conform.setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		else
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end
	end,
	formatters_by_ft = {
		markdown = { "prettierd", "prettier" },
		python = { "black" },
		lua = { "stylua" },
		go = { "gofumpt" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		lsp_format = "fallback",
		async = true,
	})
end, { desc = "Format file or range (in visual mode)" })
