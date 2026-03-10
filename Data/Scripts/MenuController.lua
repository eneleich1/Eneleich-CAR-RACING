local PRESENTATION_PAGE = script:GetCustomProperty("PresentationPage"):WaitForObject()
local SELECT_TRACK_PAGE = script:GetCustomProperty("SelectTrackPage"):WaitForObject()

local START_BUTTON = script:GetCustomProperty("StartButton"):WaitForObject()

local function ShowPage(pageToShow)
    PRESENTATION_PAGE.visibility = Visibility.FORCE_OFF
    SELECT_TRACK_PAGE.visibility = Visibility.FORCE_OFF

    pageToShow.visibility = Visibility.INHERIT
end

local function OnStartClicked(button)
    ShowPage(SELECT_TRACK_PAGE)
end


START_BUTTON.clickedEvent:Connect(OnStartClicked)

UI.SetCursorVisible(true)
UI.SetCanCursorInteractWithUI(true)

ShowPage(PRESENTATION_PAGE)