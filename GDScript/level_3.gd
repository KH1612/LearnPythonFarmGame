extends Node2D

# Relating to tile map and its layers
@onready var tile_map : TileMap = $TileMap
var grass_layer = 1
var path_layer  = 2
var props_layer = 3

var planted = false
var finished = false
var waterAnims = ["sideWater", "backWater", "frontWater"] # All watering animation names
var start = Vector2i(20,6) # Start of the 
var runCount = 0

var dialog_lines: Array[String] = []
@onready var npc = $NPC

func pickWaterAnim(): # Watering animation
	var flip = true
	if randi() %2: # Random direction
		flip = false
	$Player/AnimatedSprite2D.play(waterAnims.pick_random()) # Play the random animation and direction
	$Player/AnimatedSprite2D.flip_h = flip
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Plant.pyScript = "Level3_Plant.py" # Python script assigned to console
	# Console text assignment
	$Plant/ColorRect/PyScript.text = "# Define an empty array called 'pumpkins'

# Write a for loop that runs 56 times Hint: range(x)

	#Append True to 'pumpkins' every loop iteration
	
# Now carry the pumpkins to the chest"

	$PlacePumpkin.pyScript = "Level3_PlacePumpkin.py" # Python script assigned to console
# Console text assignment
	$PlacePumpkin/ColorRect/PyScript.text = "#Define an empty array called chest

# Create while loop that checks the condition:
# Length of 'pumpkins' isn't = 0 Hint: len(pumpkins)

	# Take the 0th index from 'pumpkins' and move it to the chest array
	# Hint: use .pop() on pumpkins and append on chest


# Proceed to the exit"

	# NPC dialogue and dialogue manager processing
	dialog_lines = [
	"Hey " + Global.getName(),
	"We need to plant and harvest some pumpkins at that patch",
	"We're going to plant them using for loops",
	"You then need to go put them in that chest using a while loop",
	"Good luck!"
	]
	npc.set_dialog(dialog_lines)
	
func handle_seed(tile_map_pos, level, atlas_coord, final_seed_level):
	# Recursive function to play the growing animation
	var source_id : int = 4
	# Find needed tilemap cell
	tile_map.set_cell(props_layer, tile_map_pos, source_id, atlas_coord)
	
	# Check if transitioning from level 4 to 5
	if level == 4: # Dont wait on animation level 4
		pass
	else:
		await get_tree().create_timer(randf_range(4.8,5.2), false).timeout  # Normal time of 5 seconds
	
	if level == final_seed_level: # Runs 6 times
		return
	else:
		var new_atlas : Vector2i = Vector2i(atlas_coord.x, atlas_coord.y + 1) # Shifts to next tile on atlas
		tile_map.set_cell(props_layer, tile_map_pos, source_id, new_atlas) # Sets new cell
		handle_seed(tile_map_pos, level + 1, new_atlas, final_seed_level) # Increase the animation level



func _on_plant_area_interacted(): # Console shown and player stopped on interaction
	$Plant.visible = true
	Global.playerStop($Player, true)


func _on_plant_close_pressed(): # On console close pressed, not visible
	$Plant.visible = false
	if planted: # If user code was correct
		for i in range(9): # Planting animation is played correct amount of times
			await get_tree().create_timer(1).timeout
			pickWaterAnim()
			for j in range(6):
				handle_seed(Vector2i(17 + i,4 + j), 0,Vector2i(53,11),6) # Vectors relate to tilemap
	Global.playerStop($Player, false) # Can move when animation finished


func _on_plant_correct_input(): # User code correct and pathing changed
	planted = true
	$ChestGlint.visible = true
	$PlantGlint.visible = false

func _on_plant_wrong_input():
	planted = false # Cant run on wrong input

func _on_chest_interacted():
	if planted: # Can interact with chest if previous phase finished
		$PlacePumpkin.visible = true
		Global.playerStop($Player, true)


func _on_place_pumpkin_close_pressed(): # Console closed and can move on close pressed
	$PlacePumpkin.visible = false
	Global.playerStop($Player, false)



func _on_place_pumpkin_correct_input():
	finished= true # Can finsih level as code is correct
	# User pathing changed
	$ExitGlint.visible = true
	$Exit2Glint.visible = true
	$ChestGlint.visible = false


func _on_place_pumpkin_wrong_input():
	finished= false # Can't finish as code incorrect



func _on_exit_body_entered(body): # Same exit logic
	if body is Player && finished:
		$ConfirmExit.visible = true
		Global.playerStop($Player, true)
	


func _on_exit_2_body_entered(body): # Same exit logic
	if body is Player && finished:
		$ConfirmExit.visible = true
		Global.playerStop($Player, true)

# Counting amount of times run was pressed
func _on_plant_run_pressed(outlines):
	runCount +=1

func _on_place_pumpkin_run_pressed(outlines):
	runCount +=1



func _on_confirm_exit_no(): # No pressed same logic
	Global.playerStop($Player, false)

func _on_tree_exited(): # Write to global stats dictionary if code is correct when exit
	if finished:
		Global.setStats('Level3',$LevelTimer/Label.text,str(runCount))
