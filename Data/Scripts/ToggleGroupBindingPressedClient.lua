
local GROUP = script:GetCustomProperty("Group"):WaitForObject()
local BINDING = script:GetCustomProperty("Binding")

local LOCAL_PLAYER = Game.GetLocalPlayer()

GROUP.visibility = Visibility.FORCE_OFF

function OnBindingPressed(whichPlayer, binding)
	if (binding == BINDING) then 
        GROUP.visibility = Visibility.INHERIT
	end
end

function OnBindingReleased(whichPlayer, binding)
	if (binding == BINDING) then
        GROUP.visibility = Visibility.FORCE_OFF
	end
end

LOCAL_PLAYER.bindingPressedEvent:Connect(OnBindingPressed)
LOCAL_PLAYER.bindingReleasedEvent:Connect(OnBindingReleased)