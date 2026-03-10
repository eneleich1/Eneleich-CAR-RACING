--[[
    Copyright 2021 Manticore Games, Inc.

    Racing Framework Documentation
    ========================

    Use this framework to kickstart your racing game creation.
    The framework includes the most basic features you need to design all sorts of racing games with consideration for multiplayer.

    Features and components included in this framework:
    ========================

    - 4 Vehicles
    - 4 Sample Race Tracks
    - Lobby (vehicle selection show room)
    - Vehicle Play Area
    - Ranking
    - Speedometer
    - Minimaps
    - Looping and non looping races
    - Customizable round logic, track settings, lap settings

    Getting Started - Gameplay Preview
    ========================

    1. Play the framework in preview mode. 
    2. Explore the Lobby, choose a vehicle.
    3. You can explore the play area while waiting for the round to start.
    4. Since the game is currently set to only 1 player, the round countdown will show up.
    5. Once the round starts, you will be teleported to the first track to race.
    6. After the first race is completed, you will be taken to lobby to wait for a new track and race again.

    Note: The game has been set with the “Required Players” at 1 for testing purposes, but don’t forget to change it to your preferred number before publishing!


    Getting Started - Map
    ========================

	Let’s look in the hierarchy and find the Map folder. It does not contain the race tracks themselves, it is for the other areas of your game. 
	Open it up and take a look at what is inside. You can see the default sky settings and the group of Spawn points that will position the player in the world when they first spawn in the game. 
	Below that you should see a “Lobby Area” and a “Race Kill” zone.

	Placing a “Race Kill Zone'' under your tracks will help make sure that players are returned to the track if they accidentally glitch through the map somehow. 
	If you need a new one, find it in the “My templates” section of your project content and size the trigger as needed. The regular kill zone won’t work for players in cars.

	The Lobby Area is here as well, that is the place that the player spawns are put out, and it holds the Vehicle selectors. 
	You can click on it in the scene to see where it is, or find them under Lobby Area/Lobby Area/Vehicle Selector Controller/Vehicle Selector Displays. 
	You don’t need to do anything to them (they read the vehicle choices from the vehicles group in the track settings). 
	But you can copy them and move them around to wherever you would like. To change their look, you will need to update the Pad Geo folder in the template.

	The Lobby Area also contains a Play Area teleporter that takes you over into the field with the jumps and things. 
	The Play Area is meant to give players something to do while waiting for races to start (they might join part way through a race). It could be anything at all that suits your game. 


    Getting Started - Custom Vehicles
    ========================

    There are 4 types of cars included in the framework: Go Kart, Pickup Truck, and Sports Car, and Formula Race.

	When you view your project content, there is a folder in My Templates called “Cars” inside that, there are four vehicles to choose from. 
	Drag each vehicle out into the scene to take a look at how they are set up, notice the player capsule, the transparent yellow wheel shapes, and the green box. 
	These objects represent the player location in the car, the vehicle body, and vehicle wheels. The locations of these objects are set on the properties of the vehicle itself. 

	To see what other properties the vehicle has, find one of the vehicles you pulled into the scene and select it in your hierarchy. 
	Scroll down in the properties panel to find all the various settings you can play with to customize the way your vehicle is set up and behaves in the scene. 
	
	Let's make a brand new vehicle to add to your scene. First, right click the Go Kart and select the option “Create New Template From This”. 
	That will make a copy of the vehicle so that you don’t accidentally mess up the original. Let’s name it “Skull Go Kart”. Now right click and select “deinstance this object” so that we can edit the car as needed. 
	
	Open up the Go Kart you made in the hierarchy and navigate down to the “Geo” folder.
	This is where you will find the parts of the visible car that make up the body. 
	Select the pipes and things that make up the body and change the paint to red by changing the colour down in the properties panel. 
	Just for fun, why don’t you find the skull in Core Content, position it on the hood, and place it inside the “Body” folder in the hierarchy.
	Now that your new Kart is finished, right click and select “Update Template From This”.
	To move your Kart into the folder with the others in Project Content, select it  and drag it over the cars folder on the left side. You can now delete it from your scene.
	
	In the lobby, copy a vehicle selector display and drag it over to sit beside one of the others. 
	We will add the vehicle to the game in the next section when it is added to the track
	

    Getting Started - Track Settings
    ========================

	Let's look at the track settings. Near the top of your hierarchy, there is a folder called track settings. 
	Inside, there is a folder with details and art for each of the track’s in the game. 
	(To add a new track, you would start by duplicating one of these folders and then moving it and changing the properties and items inside as needed).
	
	To start with, we will explore the “Track 1 Settings". Select it in your hierarchy and scroll down in it’s properties area to “Custom”. 
	There you will find the properties that control the locations this track looks for things (like the waypoints and vehicles) and also poperites of how the game will behave for this specific track. 
	So you can decide how many laps the players need to do, name your track, and specify if the track loops.
	
	Ok, now let’s look at the contents of “Track 1 Settings”.
	
	“Starting Positions” has a series of folders inside called “Race Start Positions”. 
	As the name implies, these spots will be what the game uses to place the cars on the track at the start. 
	The decal marking the spot is inside the folder and you could easily swap it for any marking you would prefer.
	
	“Waypoints” are triggers that let the game know if the car is going the right way on the track and where it is. 
	They are also used if the player needs to respawn (it moves them to the last waypoint they passed). The order in the folder is important. 
	The first one should be the start line, and they need to go from there in order around the track. 
	Note: only single path’s are supported right now with the way point system, branching paths will not work correctly.
	
	The “Vehicles” group is where we can add our new Kart to the choices for the first track. 
	Each track has its own list of vehicles so you can make the options fit the track. Let’s try that now. 
	Copy the bottom Vehicle Reference, and then open its properties. Find your Kart in the “Project Content” and then drag it over the template symbol beside where it says “Vehicle”. 
	Now hit play on your scene and look at the Vehicle selector you added, your car should show up there and you can take it for a spin. That is it for the first track’s settings.
	
	The other major folder to notice inside of “Track 1” is the “Geo” folder, this is where you can alter the look of your roads, environment, and finish line. 
	For the framework, roads from core content were used to make the tracks, if you have snapping enabled it is quick to place out the pieces into nice big tracks. 
	But you could easily use basic shapes or terrain to build all kinds of amazing race courses. 

    Getting Started - Game Settings
    ========================

	Most of the items in this folder you won’t need to mess with too much initially, but let’s take a look at what is inside the “Game State Round Settings” folder. 
	The groups in here have custom properties set on them that allow you to change some timing and duration settings that affect the whole game rather than just one map. 
	For instance, “Racing Round” lets you adjust the timing of the Round End Countdown Time.
	
	For now though, click on “Lobby Required Players” and check out the custom property section. 
	Notice the part that says “Required Players”, make sure that is set to the value you want before you publish your game.
	
	That should be enough to get you starting making your very own track! Have fun :)
	
	Getting Started - Tips & Tricks
    ========================
    
    When you are setting up your own maps, making a custom material to apply to anything you have to repeat a lot is a good idea. So for example, the track pieces.
    A custom material has been set up for both the track and the environment of track 2 (the dirt track with the hill).
	In your project content, try opening up "Shared Material Race Track Dirt Environment" so that you are viewing the Material Editor. 
	Replace the Forest Floor Material with "Snow 01" and replace the Dirt 01 with "Ice Opaque". 
	Now in your project's content, open up "Shared Material Race Track Dirt Road" and change the colour to something wintery.
	Perfect! You now have a very wintery scene to drive through.
	
	Another very good tip, has to do with mass replacing materials on objects. 
	In your hierarchy, select a whole group of things that you want to change to a new material, like for example the buildings.
	Now, in Core content, right click and drag the material you would like to use right over top of your selection in the hierarchy.
	It will apply to all slots on the objects and is a super quick way to change the look of your level!
   
    One of the problems you might come across while designing maps is colliding with things you cannot see, so let's learn about changing views.
    Up in the top right hand corner of the editor window is a little drop down that is probably set to "Default View" click it.
    Those options will allow you to select various views, including "Player Collision" to help you track down problems with your map.

--]]