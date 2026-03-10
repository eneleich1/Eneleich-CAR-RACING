--[[ 
    This script sends an event to server using keybinding hold.a
    It uses progress bar to show the hold progress.
 ]]

local propProgressBar = script:GetCustomProperty("ProgressBar"):WaitForObject()
local propBinding = script:GetCustomProperty("Binding")
local propHoldDuration = script:GetCustomProperty("HoldDuration")
local propBroadcastEvent = script:GetCustomProperty("BroadcastEvent")
local propBroadcastServerEvent = script:GetCustomProperty("BroadcastServerEvent")
local disableOnVisibilityOff = script:GetCustomProperty("DisableOnVisibilityOff")

local LOCAL_PLAYER = Game.GetLocalPlayer()

local isPressing = false
local pressedTime = 0

if propHoldDuration <= 0 then
    warn("HoldDuration should be higher than 0")
    propHoldDuration = 1
end

function SendEvents()
    if propBroadcastEvent ~= "" then
        Events.Broadcast(propBroadcastEvent)
    end
    if propBroadcastServerEvent ~= "" then
        local result = Events.BroadcastToServer(propBroadcastServerEvent)
        while result ~= BroadcastEventResultCode.SUCCESS do
            result = Events.BroadcastToServer(propBroadcastServerEvent)
            Task.Wait()
        end
    end
end

function Tick()
    if isPressing then
        if time() - pressedTime > propHoldDuration then
            propProgressBar.progress = 0
            isPressing = false
            SendEvents()
        else
            propProgressBar.progress = (time() - pressedTime) / propHoldDuration
        end
    else
        if propProgressBar.progress > 0 then
            propProgressBar.progress = 0
        end
    end
end

function OnBindingPressed(whichPlayer, binding)
    if disableOnVisibilityOff and not propProgressBar:IsVisibleInHierarchy() then
        return
    end

    if binding == propBinding then
        isPressing = true 
        pressedTime = time()
    end
end

function OnBindingReleased(whichPlayer, binding)
    if binding == propBinding then 
        isPressing = false 
    end
end

LOCAL_PLAYER.bindingPressedEvent:Connect(OnBindingPressed)
LOCAL_PLAYER.bindingReleasedEvent:Connect(OnBindingReleased)

