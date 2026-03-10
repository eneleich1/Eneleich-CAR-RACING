local AAP = require(script:GetCustomProperty("APIActivePlayers"))

local GROUP = script:GetCustomProperty("Group"):WaitForObject()
local OFF_WHEN_ACTIVE = script:GetCustomProperty("OffWhenActive")

local LOCAL_PLAYER = Game.GetLocalPlayer()

function ShowUI()
    if OFF_WHEN_ACTIVE then
        GROUP.visibility = Visibility.FORCE_OFF
    else
        GROUP.visibility = Visibility.INHERIT
    end
end

function HideUI()
    if OFF_WHEN_ACTIVE then
        GROUP.visibility = Visibility.INHERIT
    else
        GROUP.visibility = Visibility.FORCE_OFF
    end
end

function OnPlayerActive(player)
    if player == LOCAL_PLAYER then
        ShowUI()
    end
end

function OnPlayerNonActive(player)
    if player == LOCAL_PLAYER then
        HideUI()
    end
end

Events.Connect(AAP.PLAYER_ACTIVE_EVENT, OnPlayerActive)
Events.Connect(AAP.PLAYER_NON_ACTIVE_EVENT, OnPlayerNonActive)

if AAP.IsPlayerActive(LOCAL_PLAYER) then
    OnPlayerActive(LOCAL_PLAYER)
else
    OnPlayerNonActive(LOCAL_PLAYER)
end
