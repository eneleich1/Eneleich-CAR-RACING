--[[
    Simple main menu flow for lobby entry.
    Shows a Multiplayer button while in lobby.
    Reuses existing server flow via MainMenu_PlayMultiplayer event.
--]]

local ABGS = require(script:GetCustomProperty("APIBasicGameState"))

local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()
local PANEL = script:GetCustomProperty("Panel"):WaitForObject()
local MULTIPLAYER_BUTTON = script:GetCustomProperty("MultiplayerButton"):WaitForObject()

local menuVisible = false
local dismissedThisLobby = false
local wasInLobby = false

local function SetMenuVisible(shouldShow)
    if menuVisible == shouldShow then
        return
    end

    menuVisible = shouldShow
    PANEL.visibility = shouldShow and Visibility.INHERIT or Visibility.FORCE_OFF
    UI.SetCursorVisible(shouldShow)
    UI.SetCanCursorInteractWithUI(shouldShow)
end

local function IsInLobbyState()
    if not ABGS.IsGameStateManagerRegistered() then
        return false
    end

    return ABGS.GetGameState() == ABGS.GAME_STATE_LOBBY
end

local function RefreshMenuState()
    local inLobby = IsInLobbyState()

    if inLobby and not wasInLobby then
        dismissedThisLobby = false
    elseif not inLobby and wasInLobby then
        dismissedThisLobby = false
    end

    wasInLobby = inLobby
    SetMenuVisible(inLobby and not dismissedThisLobby)
end

local function OnMultiplayerClicked()
    if dismissedThisLobby then
        return
    end

    dismissedThisLobby = true
    SetMenuVisible(false)
    Events.BroadcastToServer("MainMenu_PlayMultiplayer")
end

function Tick()
    RefreshMenuState()
end

MULTIPLAYER_BUTTON.clickedEvent:Connect(OnMultiplayerClicked)
SetMenuVisible(false)
