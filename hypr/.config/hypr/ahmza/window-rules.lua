-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "steam-friends-list-float",
	match = {
		initial_class = "steam",
		initial_title = "Friends List",
	},
	float = true,
	size = { 600, 800 },
	center = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- class-based rules: workspace and/or opacity (nil fields are ignored)
for _, r in ipairs({
	{ name = "Ghostty", class = "com.mitchellh.ghostty", opacity = "0.8 override 0.7 override 0.8 override" },
	{ name = "Firefox", class = "firefox", opacity = "0.9 override 0.7 override 1 override", workspace = 2 },
	{ name = "Obsidian", class = "md.Obsidian", workspace = 4 },
	{ name = "Steam", class = "steam", workspace = 3 },
	{ name = "Steam Apps", class = "^(?i)steam_app_.*", workspace = 3 },
	{ name = "Discord", class = "discord", workspace = 8 },
	{ name = "Feishin", class = "feishin", workspace = 9 },
}) do
	hl.window_rule({ name = r.name, match = { class = r.class }, workspace = r.workspace, opacity = r.opacity })
end

-- float-only rules
for _, class in ipairs({
	"xdg-desktop-portal",
	"xdg-desktop-portal-gtk",
	"xdg-desktop-portal-hyprland",
	"com.nextcloud.desktopclient.nextcloud",
	"io.github.kolunmi.Bazaar",
}) do
	hl.window_rule({ name = class, match = { class = class }, float = true })
end

-- layer blur rules
for _, ns in ipairs({ "waybar", "fuzzel" }) do
	hl.layer_rule({ match = { namespace = ns }, blur = true })
end
