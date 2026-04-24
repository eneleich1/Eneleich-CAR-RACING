local LOCAL_PLAYER = Game.GetLocalPlayer()

local isReady = false

function OnBindingPressed(player, binding)
    if binding == "ability_extra_38" then  -- L key
        if not isReady then
            isReady = true
            print("Player is READY")

            Events.BroadcastToServer("PlayerReady")
        end
    end
end

LOCAL_PLAYER.bindingPressedEvent:Connect(OnBindingPressed)