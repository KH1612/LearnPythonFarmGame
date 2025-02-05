extends Node2D

var eggCount = 0
var collect = false
var finished = false
var runCount = 0

var dialog_lines: Array[String] = []
@onready var npc = $NPC

func eggCheck(): # Checking if all 5 eggs have been collected
	eggCount +=1
	if eggCount == 5:
		collect = true # Can move onto next phase
		$ChestGlint.visible = true # User pathing shown

func _ready():
	$Collect.pyScript = "Level2_Collect.py" 
	$Collect/ColorRect/PyScript.text = "# Declare an empty array called 'eggs' (e.g. array = [])

# Append a True value to the array using .append()
# Repeat this 5 times





# Repetition of code is inefficient, this will be solved in the next level
# Collect 5 eggs from the chicken pen then proceed to the other chest"
	# Text assigned to be in the console
	
	$InChest.pyScript = "Level2_InChest.py" # Python script for the console class
	
	$InChest/ColorRect/PyScript.text = "# A chest array with 5 emply index slots has been given
# chest =  [False, False, False, False, False]
# Use your eggs array to put each egg into the chest using indexes
# The index is the number in the square brackets that relates to a position in the array
chest[0] = eggs[0]
# The first statement has been done for you. Repeat for all indexes (0-4)




# This repetition will also be solved in the next level
# Proceed to the exit"
# Text assigned to be in the console
	dialog_lines = [ # NPC dialogue lines
	"Time to collect some eggs!",
	"Your going to need put each of the eggs into an array",
	"All your collecting equipment is in the chest",
	"Then you can walk up to and collect all 5 eggs",
	"The barn door open when all the eggs are in the second chest"
	]
	
	npc.set_dialog(dialog_lines) # Handle this dialogue in the dialogue manager class


func _on_chest_2_interacted(): # Console visible on chest interact, player stopped
	$Collect.visible = true
	Global.playerStop($Player, true)


func _on_collect_close_pressed(): # Console not visible when close pressed and player can move
	$Collect.visible = false
	Global.playerStop($Player, false)

func _on_collect_correct_input():
	$CollectGlint.visible = false # Change pathing
	# Get all egg nodes and change their status to collectable
	var eggs = get_tree().get_nodes_in_group("Eggs")
	for node in eggs:
		if node is egg:
			node.collectable = true

# Checking if all 5 eggs have been collected
func _on_egg_interacted():
	eggCheck()

func _on_egg_2_interacted():
	eggCheck()

func _on_egg_3_interacted():
	eggCheck()

func _on_egg_4_interacted():
	eggCheck()

func _on_egg_5_interacted():
	eggCheck()

func _on_chest_interacted(): # Chest interacted
	if collect: # If all eggs collected
		$InChest.visible = true # Can show console
		Global.playerStop($Player, true) # Stop player

func _on_in_chest_close_pressed(): # Console not visible anymore, player can move
	$InChest.visible = false
	Global.playerStop($Player, false)

func _on_in_chest_correct_input(): # On user code correct
	# Pathing changed
	$ExitGlint.visible = true
	$ChestGlint.visible = false
	finished = true # Level can be exited
	$StaticBody2D/BarnDoor.disabled = true # Barn door opened


func _on_in_chest_wrong_input(): # Can't leave on wrong input
	finished = false
	$StaticBody2D/BarnDoor.disabled = false

func _on_exit_body_entered(body): # Same exit logic
	if body is Player:
		$ConfirmExit.visible = true
		Global.playerStop($Player, true)

func _on_confirm_exit_no(): # Player can move again on no pressed
	Global.playerStop($Player, false)

# runCount increased when pressed
func _on_in_chest_run_pressed(outlines):
	runCount +=1


func _on_collect_run_pressed(outlines):
	runCount +=1

func _on_tree_exited(): # Stats updated when user leaves and code was correct
	if finished:
		Global.setStats('Level2',$LevelTimer/Label.text,str(runCount))

