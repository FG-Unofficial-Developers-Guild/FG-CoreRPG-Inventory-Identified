--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
-- luacheck: globals hideOrShowID

function hideOrShowID()
    if super then
        super.ignorehost = (OptionsManager.isOption("PS-NONID-NAME", "on") and Session.IsHost)
        if super.onValueChanged then
            super.onValueChanged()
        end
    end
end

function onInit()
    if super.onInit then
        super.onInit();
    end

    OptionsManager.registerCallback("PS-NONID-NAME", hideOrShowID);

    hideOrShowID();
end

function onClose()
    if super.onClose then
        super.onClose();
    end

    OptionsManager.unregisterCallback("PS-NONID-NAME", hideOrShowID);
end