hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(Terminal .. " +new-window"))
hl.bind("SUPER + Q", hl.dsp.window.close())

hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprlock"))

hl.bind("SUPER + M", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + E", hl.dsp.exec_cmd(FileManager))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(Picker))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
for _, d in ipairs({ "left", "right", "up", "down" }) do
	hl.bind("SUPER + " .. d, hl.dsp.focus({ direction = d }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia + LCD brightness keys (playerctl required for media keys)
for _, b in ipairs({
	{ "XF86AudioRaiseVolume", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", { locked = true, repeating = true } },
	{ "XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", { locked = true, repeating = true } },
	{ "XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", { locked = true, repeating = true } },
	{ "XF86AudioMicMute", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", { locked = true, repeating = true } },
	{ "XF86MonBrightnessUp", "brightnessctl -e4 -n2 set 5%+", { locked = true, repeating = true } },
	{ "XF86MonBrightnessDown", "brightnessctl -e4 -n2 set 5%-", { locked = true, repeating = true } },
	{ "XF86AudioNext", "playerctl next", { locked = true } },
	{ "XF86AudioPause", "playerctl play-pause", { locked = true } },
	{ "XF86AudioPlay", "playerctl play-pause", { locked = true } },
	{ "XF86AudioPrev", "playerctl previous", { locked = true } },
}) do
	hl.bind(b[1], hl.dsp.exec_cmd(b[2]), b[3])
end
