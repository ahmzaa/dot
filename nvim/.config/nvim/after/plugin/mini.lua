require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()

local statusline = require("mini.statusline")
statusline.setup()
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end
