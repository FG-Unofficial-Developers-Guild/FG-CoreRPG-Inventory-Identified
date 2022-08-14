--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
-- luacheck: globals onValueChanged ignorehost class nonIDColor

local nodeSrc = nil;
function onInit()
    nodeSrc = window.getDatabaseNode();
    if nodeSrc then
        onValueChanged();
        DB.addHandler(DB.getPath(nodeSrc, "isidentified"), "onUpdate", onValueChanged);
    end
end

function onClose()
    if nodeSrc then
        DB.removeHandler(DB.getPath(nodeSrc, "isidentified"), "onUpdate", onValueChanged);
    end
end

function nonIDColor(bID)
    if not bID and Session.IsHost then
        window.nonid_name.setColor(ColorManager.COLOR_HEALTH_CRIT_WOUNDS);
    else
        window.nonid_name.setColor(ColorManager.COLOR_FULL);
    end
end

function onValueChanged()
    if window.onIDChanged then
        window.onIDChanged();
    elseif class then
        local bIgnoreHost = false;
        if ignorehost then bIgnoreHost = true; end
        local bID = LibraryData.getIDState(class[1], nodeSrc, bIgnoreHost);
        window.name.setVisible(bID);
        window.nonid_name.setVisible(not bID);

        -- bmos color-coding nonID names
        nonIDColor(bID)
    end
end