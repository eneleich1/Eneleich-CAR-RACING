local VEHICLE = script:GetCustomProperty("Vehicle")

World.SpawnAsset(VEHICLE, {position = script:GetWorldPosition(), rotation = script:GetWorldRotation()})
