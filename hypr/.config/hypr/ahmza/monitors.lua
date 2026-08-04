-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "DP-1",
	mode = "preferred",
	position = "0x0",
	scale = "auto",
})

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@239.97",
	position = "0x1440",
	scale = "auto",
	bitdepth = 10,
	vrr = 2,
	cm = "hdr",
	sdrbrightness = 1.5,
	sdrsaturation = 1.5,
	sdr_min_luminance = 0,
	sdr_max_luminance = 100,
})
