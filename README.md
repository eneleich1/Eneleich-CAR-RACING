# Eneleich CAR RACING

Eneleich CAR RACING is a multiplayer kart racing game built in Core. The project uses Core's Racing Framework as a base and expands it with cup selection, vehicle selection, race rounds, laps, checkpoints, minimaps, ranked UI, and arcade-style item mechanics.

The game flow is designed around a Mario Kart-like loop: players start in a presentation/menu scene, choose a cup, select a vehicle in the lobby, race through the selected cup tracks, return to the lobby between races, and continue cycling through the available tracks.

## Features

- Multiplayer racing for up to 8 players.
- Presentation scene, cup selection, lobby, and race scenes.
- Multiple cup scenes, including Default Cup and Mariel Cup.
- Vehicle selector with several playable vehicles such as go-karts, sports cars, pickup trucks, police cars, taxis, and formula race cars.
- Round-based race flow with lobby, countdown, race, round end, and reset states.
- Track cycling system that automatically advances to the next race after each round.
- Lap tracking, checkpoints, respawn support, wrong-way detection, and race finish handling.
- Minimap, speedometer, lap display, ranked playerboard, nameplates, scoreboard, and banner messages.
- Item box and inventory system with two item slots.
- Arcade racing items, including mushroom boost, banana drop, and green shell projectile behavior.
- Community content experiments for blue shell and randomized lightning effects.
- PC and mobile publishing support.

## Project Structure

```text
CommunityContent/   Imported and experimental community assets
Data/               Main Core project data, scenes, templates, materials, and Lua scripts
PublishData/        Core publishing configuration
UserSettings/       Local Core user settings
Meta.pbt            Core project metadata
```

Important areas:

- `Data/Scenes/Presentation Scene_1` contains the main presentation/menu scene.
- `Data/Scenes/Default Cup Scene` contains one playable cup scene.
- `Data/Scenes/Mariel Cup Scene` contains another playable cup scene.
- `Data/Scripts` contains the gameplay logic written in Lua.
- `Data/Templates` contains reusable Core templates for vehicles, UI, track systems, and items.

## Gameplay Flow

1. Players enter the presentation scene.
2. A cup is selected.
3. Players move into the kart selection/lobby area.
4. When the race starts, players are spawned into the current track.
5. The race system tracks laps, checkpoints, ranking, race completion, and round state.
6. After a race ends, players return to the lobby.
7. The next track in the cup is selected automatically.
8. After the last track, the cup cycle starts again from the first track.

## Core Systems

### Race Management

Race state is controlled by the Basic Game State and Racing Round scripts. The game broadcasts events such as `StartRace`, `EndRace`, `ResetRace`, and `RaceTrackChanged` to coordinate the race lifecycle.

### Track Management

The track manager registers available race tracks, selects the starting track, and cycles through tracks after each completed round.

### Vehicle Systems

The project includes vehicle spawning, vehicle selection displays, camera control, speedometer UI, engine effects, honking, lights, passenger handling, grounding, and upright recovery.

### Item Systems

The item system supports item boxes, client inventory UI, item usage events, and server-side item effects. Current implemented items include:

- Mushroom boost
- Banana trap
- Green shell projectile

Additional imported or experimental content includes blue shell and lightning assets.

## Development Notes

This repository is a Core game project. To edit or run it, open the project from Core's local saved maps directory or import the project files into Core.

The main project metadata identifies the game as:

- Name: `Eneleich CAR RACING`
- Framework: `Community`
- Main Scene: `Presentation Scene`
- Max Players: `8`
- Platforms: `PC` and `Mobile`
- Tag: `Racing`

## Credits

Built with Core by Manticore Games and based on Core's Racing Framework. Custom gameplay changes, scenes, item behavior, and project composition are part of the Eneleich CAR RACING project.
