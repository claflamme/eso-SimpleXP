function xp.buildControlPanel()

	local menuId = LAM:CreateControlPanel('sxpConfig', 'SimpleXP')

	-- -------------------------------------------------------------------------
	-- Experience Bar
	-- -------------------------------------------------------------------------
	LAM:AddHeader(menuId, 'sxpHeaderExperienceBar', 'Experience Bar')

	-- Background color
	LAM:AddColorPicker(
		menuId,
		'sxpConfigDrpdwn_XpBarBgColor',
		'Background Color',
		'You can disable the background by turning the Opacity down.',
		function() local color = xp.sv.xpBgColor return color.r, color.g, color.b,color.a end,
		function(r, g, b, a) xp.updateSetting('xpBgColor', {r = r, g = g, b = b, a = a}) end
	)

	-- Foreground color
	LAM:AddColorPicker(
		menuId,
		'sxpConfigDrpdwn_XpBarFgColor',
		'Foreground Color',
		'The colour of the XP progress bar.',
		function() local color = xp.sv.xpFgColor return color.r, color.g, color.b,color.a end,
		function(r, g, b, a) xp.updateSetting('xpFgColor', {r = r, g = g, b = b, a = a}) end
	)

	-- Bar Height
	LAM:AddSlider(
		menuId,
		'sxpConfigDrpdwn_XpBarHeight',
		'Height',
		'The vertical size of the XP bar.',
		1,
		10,
		1,
		function() return xp.sv.xpHeight end,
		function(val) xp.updateSetting('xpHeight', val) end
	)

end