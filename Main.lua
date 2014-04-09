-- Load libraries
LAM = LibStub:GetLibrary('LibAddonMenu-1.0')
LMP = LibStub:GetLibrary('LibMediaProvider-1.0')

WM = WINDOW_MANAGER

xp = { sv = {}, events = {} }
ui = {}

xp.config = {
	name = 'SimpleXP',
	svName = 'SimpleXP_SavedVariables',
	framesToCheck = {
		ZO_MainMenuCategoryBar,
		ZO_InteractWindow,
		ZO_GameMenu_InGame
	}
}

function xp.createControls()

	SimpleXP:SetHandler('OnUpdate', xp.onUpdate)

	ui.bg = WM:CreateControl('SimpleXP_BG', SimpleXP, CT_STATUSBAR)
	ui.bg:SetOrientation(ORIENTATION_HORIZONTAL)
	ui.bg:SetBarAlignment(BAR_ALIGNMENT_NORMAL)
	ui.bg:SetWidth(GuiRoot:GetWidth())
	ui.bg:SetSimpleAnchorParent(0, 0)
	ui.bg:SetDrawLayer(1)
	ui.bg:SetMouseEnabled(true)

	ui.xp = WM:CreateControl('SimpleXP_XP', ui.bg, CT_STATUSBAR)
	ui.xp:SetOrientation(ORIENTATION_HORIZONTAL)
	ui.xp:SetBarAlignment(BAR_ALIGNMENT_NORMAL)
	ui.xp:SetWidth(GuiRoot:GetWidth())
	ui.xp:SetSimpleAnchorParent(0, 0)
	ui.xp:SetDrawLayer(1)
	ui.xp:SetMouseEnabled(true)

	xp.updateControls()

end

function xp.updateControls()

	local bgColor = xp.sv.xpBgColor
	local fgColor = xp.sv.xpFgColor

	ui.bg:SetColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
	ui.bg:SetHeight(xp.sv.xpHeight)

	ui.xp:SetColor(fgColor.r, fgColor.g, fgColor.b, fgColor.a)
	ui.xp:SetHeight(xp.sv.xpHeight)

	xp.updateXp()

end

function xp.updateXp()

	-- If the function is called before the control is created
	if ui.xp == nil then return false end

	if IsUnitVeteran('player') then
		ui.xp:SetMinMax(0, GetUnitVeteranPointsMax('player'))
		ui.xp:SetValue(GetUnitVeteranPoints('player'))
	else
		ui.xp:SetMinMax(0, GetUnitXPMax('player'))
		ui.xp:SetValue(GetUnitXP('player'))
	end

end

function xp.updateSetting(settingName, settingVal)

	xp.sv[settingName] = settingVal
	xp.updateControls()

end

function xp.onUpdate()

	-- Just uses any old control from the menu to see if it's visible
	if sxpHeaderExperienceBar:IsHidden() and xp.isHidden() then
		SimpleXP:SetAlpha(0)
	else
		SimpleXP:SetAlpha(1)
	end

end

function xp.isHidden()

	for _, frame in pairs(xp.config.framesToCheck) do
		if not frame:IsHidden() then
			return true
		end
	end

	return false

end
