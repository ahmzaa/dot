-- workspace -> monitor (comment = expected windows)
for _, r in ipairs({
	{ "1", "DP-3" }, -- Terminal
	{ "2", "DP-1" }, -- Browser
	{ "3", "DP-3" }, -- Games
	{ "4", "DP-3" }, -- Notes
	{ "5", "DP-3" },
	{ "6", "DP-3" },
	{ "7", "DP-3" },
	{ "8", "DP-3" }, -- Social
	{ "9", "DP-1" }, -- Music
}) do
	hl.workspace_rule({ workspace = r[1], monitor = r[2] })
end
