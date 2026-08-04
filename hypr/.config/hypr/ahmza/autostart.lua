-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("xrandr --output DP-3 --primary")
	hl.exec_cmd("uwsm app waybar & uwsm app awww-daemon")
	hl.exec_cmd("uwsm app ghostty", { workspace = "1" })
	hl.exec_cmd("uwsm app firefox", { workspace = "2" })
	hl.exec_cmd("uwsm app flatpak run org.jeffvli.feishin", { workspace = "9" })
	hl.exec_cmd("uwsm app steam", { workspace = "3" })
	hl.exec_cmd("uwsm app discord", { workspace = "8" })
	hl.exec_cmd("uwsm app flatpak run mc.obsidian.Obsidian", { workspace = "4" })
	hl.exec_cmd("uwsm app nm-applet")
end)
