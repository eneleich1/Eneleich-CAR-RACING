local UI_PANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
UI_PANEL.visibility = Visibility.FORCE_OFF

local wrongWayTaskHandler = nil

function OnRaceWrongWay()
    if wrongWayTaskHandler then
        wrongWayTaskHandler:Cancel()
    end

    -- Store this task
    wrongWayTaskHandler = Task.current

    UI_PANEL.visibility = Visibility.INHERIT
    Task.Wait(0.2)
    UI_PANEL.visibility = Visibility.FORCE_OFF

    wrongWayTaskHandler = nil
end

Events.Connect("RaceWrongWay", OnRaceWrongWay)


