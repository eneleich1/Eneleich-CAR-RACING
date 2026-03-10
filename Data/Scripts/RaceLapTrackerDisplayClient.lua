local PANEL = script:GetCustomProperty("Panel"):WaitForObject()
local LAP_PANEL = script:GetCustomProperty("LapPanel"):WaitForObject()
local RACE_TIME_PANEL = script:GetCustomProperty("RaceTimePanel"):WaitForObject()
local LAP_TIME_PANEL = script:GetCustomProperty("LapTimePanel"):WaitForObject()
local BEST_TIME_PANEL = script:GetCustomProperty("BestTimePanel"):WaitForObject()

function GET(obj, p) return obj:GetCustomProperty(p):WaitForObject() end

local LAP_COUNTER = GET(LAP_PANEL, "CounterText")
local RACE_TIMER = GET(RACE_TIME_PANEL, "TimerText")
local LAP_TIMER = GET(LAP_TIME_PANEL, "TimerText")
local BEST_TIMER = GET(BEST_TIME_PANEL, "TimerText")

local LOCAL_PLAYER = Game.GetLocalPlayer()

local startTime = time()
local raceTimeOffset = 0
local bestLapTime = nil

local currentLap = 0
local numberOfLaps = 3

local timerStarted = false
local isRacing = false
local hasFinishedRace = false

function SecondsToCounterString(totalSeconds)
    local currentTime = totalSeconds

    currentTime = currentTime * 1000

    currentTime = math.floor(currentTime)

    local milliseconds = currentTime % 1000
    currentTime = currentTime-milliseconds
    currentTime = math.floor(currentTime / 1000)

    local seconds = currentTime % 60
    currentTime = currentTime - seconds
    currentTime = math.floor(currentTime/60)

    local minutes = math.min(currentTime, 99)

    return string.format("%02d.%02d.%03d", minutes, seconds, milliseconds)
end

-- Sets the timers to 00.00.000
function ResetCounters()
    RACE_TIMER.text = SecondsToCounterString(0)
    LAP_TIMER.text = SecondsToCounterString(0)
end

function Tick()
     if timerStarted then
        local currentLapTime = (time() - startTime)
        LAP_TIMER.text = SecondsToCounterString(currentLapTime)
        RACE_TIMER.text = SecondsToCounterString(raceTimeOffset + currentLapTime)
    end

    if bestLapTime then
        BEST_TIME_PANEL.visibility = Visibility.INHERIT
        BEST_TIMER.text = SecondsToCounterString(bestLapTime)
    else
        BEST_TIME_PANEL.visibility = Visibility.FORCE_OFF
    end

    local raceLap = currentLap

    if raceLap == 0 then
        PANEL.visibility = Visibility.FORCE_OFF
    elseif hasFinishedRace then
        PANEL.visibility = Visibility.FORCE_OFF
    elseif isRacing then
        PANEL.visibility = Visibility.INHERIT
        LAP_COUNTER.text = tostring(raceLap) .. "/" .. tostring(numberOfLaps)
    end
end

function OnRaceLapFinished(lap, lapTime, currentRaceTime)
    startTime = time()
    raceTimeOffset = currentRaceTime
    currentLap = lap+1

    if bestLapTime == nil or bestLapTime > lapTime then
        bestLapTime = lapTime
    end

    RACE_TIMER.text = SecondsToCounterString(currentRaceTime)
    LAP_TIMER.text = SecondsToCounterString(lapTime)
end

function OnRaceStarted(laps)
    bestLapTime = nil
    raceTimeOffset = 0
    startTime = 0
    timerStarted = false

    currentLap = 0
    numberOfLaps = laps
    isRacing = true
    hasFinishedRace = false

    ResetCounters()
end

function OnRaceEnded()
    -- Race is over, resetting
    isRacing = false
end

function OnRaceLapStarted()
    startTime = time()
    timerStarted = true
    currentLap = 1
end

function OnRaceReset()
    bestLapTime = nil
    raceTimeOffset = 0
    startTime = 0
    currentLap = 0
    timerStarted = false
    ResetCounters()
end

function OnRaceFinalLapFinished(lapTime, raceTime)
    timerStarted = false

    raceTimeOffset = raceTimeOffset
    if bestLapTime == nil or bestLapTime > lapTime then
        bestLapTime = lapTime
    end

    RACE_TIMER.text = SecondsToCounterString(raceTime)
    LAP_TIMER.text = SecondsToCounterString(lapTime)

    hasFinishedRace = true
end

-- Server message
Events.Connect("RaceLapFinished", OnRaceLapFinished)
Events.Connect("RaceLapStarted", OnRaceLapStarted)
Events.Connect("RaceFinalLapFinished", OnRaceFinalLapFinished)
Events.Connect("StartRace", OnRaceStarted)
Events.Connect("EndRace", OnRaceEnded)
Events.Connect("ResetRace", OnRaceReset)

ResetCounters()