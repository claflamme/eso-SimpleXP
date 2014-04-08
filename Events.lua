---
-- Called whenever an addon is loaded, checks if it's our addon that loaded.
--
-- @param eventCode
-- @param addonName The name of that addon that just loaded.
xp.events.EVENT_ADD_ON_LOADED = function(eventCode, addonName)

	if (addonName == xp.config.name) then
		EVENT_MANAGER:UnregisterForEvent(xp.config.name, eventCode)
		xp.sv = ZO_SavedVars:NewAccountWide(xp.config.svName, 1, xp.config.name, xp.defaults)
		xp.buildControlPanel()
		xp.createControls()
	end

end

xp.events.EVENT_EXPERIENCE_UPDATE = function(eventCode, unitTag, currentExp, maxExp, reason)

	if unitTag == 'player' then
		xp.updateXp()
	end

end

-- Bind all declared handlers to their respective events.
for eventName, handler in pairs(xp.events) do
	EVENT_MANAGER:RegisterForEvent(xp.config.name, _G[eventName], handler)
end
