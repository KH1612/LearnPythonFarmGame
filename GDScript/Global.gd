extends Node

var savePath = "user://savegame.save" # Savefile in appdata
var defaultStats = { # Defaults stats for reset or first time player
	"player" : "Player1",
	"Level0" : [null, null],
	"Level1" : [null, null],
	"Level2" : [null, null],
	"Level3" : [null, null],
	"Level4" : [null, null],
	"Level5" : [null, null]
}
var savedStats


func saveGame():
	# Function that saves the stats dictionary to a file in appdata
	var saveLoc = FileAccess.open(savePath, FileAccess.WRITE)
	if savedStats == null: # For first time launch return default stats
		savedStats = defaultStats
	var jsonString = JSON.stringify(savedStats)

	saveLoc.store_line(jsonString) # Store in JSON string in file

func loadGame(): # Load the JSON string from the save file
	if not FileAccess.file_exists(savePath):
		return
	var saveLoc = FileAccess.open(savePath, FileAccess.READ)

	var json_string = saveLoc.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	var node_data = json.get_data()
	savedStats = node_data # Put the JSON string as a dictionary in global



func playerStop(player : Player, stop : bool): # Stops the player object from being able to move
	player.stopped = stop

func setStats(level,time, runCount): 
	# Sets the stats on the level select page if they are better than previous
	var arr = savedStats[level]
	if arr[0] == null:
		arr[0] = time
		arr[1] = runCount
	else:
		if int(time) < int(arr[0]):
			arr[0] = time
		if int(runCount) < int(arr[1]):
			arr[1] = runCount

func Reset(): # Called to reset player stats
	Global.savedStats = Global.defaultStats
	Global.saveGame()

func getName(): # Name getter
	return savedStats['player']

func setName(name): # Name setter
	savedStats['player'] = name
	saveGame()
