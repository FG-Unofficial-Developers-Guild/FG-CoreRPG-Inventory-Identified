--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
-- luacheck: globals onValueChanged ignorehost class colorUnidentified

local nodeSrc = nil
function onInit()
	if super and super.onInit then super.onInit() end

	nodeSrc = window.getDatabaseNode()
	if nodeSrc then
		onValueChanged()
		DB.addHandler(DB.getPath(nodeSrc, 'isidentified'), 'onUpdate', onValueChanged)
	end
end

function onClose()
	if super and super.onClose then super.onClose() end

	if nodeSrc then DB.removeHandler(DB.getPath(nodeSrc, 'isidentified'), 'onUpdate', onValueChanged) end
end

function colorUnidentified(bID)
	local color = ColorManager.COLOR_FULL
	if not bID and Session.IsHost then color = ColorManager.COLOR_HEALTH_CRIT_WOUNDS end
	window.nonid_name.setColor(color)
end

function onValueChanged()
	if super and super.onValueChanged then super.onValueChanged() end

	if window.onIDChanged then
		window.onIDChanged()
	elseif class then
		local bID = LibraryData.getIDState(class[1], nodeSrc, ignorehost or (super and super.ignorehost))
		window.name.setVisible(bID)
		window.nonid_name.setVisible(not bID)

		-- bmos color-coding nonID names
		colorUnidentified(bID)
	end
end
