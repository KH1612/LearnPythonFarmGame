extends Node2D
var finished = false
var runCount = 0

var npc_lines: Array[String] = []
@onready var npc = $NPC
	
func _ready():
	$IfPlant.pyScript = "Level1_IfPlant.py" # Python script assigned to console
	
	$IfPlant/ColorRect/PyScript.text = " # You have been given an if elif else statement
# Your job is to assign the correct boolean values to the 2 variables below
# to ensure that the radishes are planted before the sunflowers
# You will be asked to write your own if statements in a future level!

radishPlanted = 
sunflowerPlanted =
	
if radishPlanted and not sunflowerPlanted:
	result = 'Radishes are being planted first then the sunflowers'
elif not radishPlanted and sunflowerPlanted:
	result = 'Radishes must be planted first'
elif radishPlanted and sunflowerPlanted:
	result = 'You cant plant both at the same time'
else:
	result = 'At least one variable must be true!'
print(result)"

	
	npc_lines = [
	"Hey there, " + Global.getName() + "! I need your help with a little planting task", 
	"See, I need to only plant sunflowers once the radishes have been planted",
	"You’ll need an if statement to check if the radishes have been planted.",
	"Go get the seeds from the chest and give it a shot!"
	]
	npc.set_dialog(npc_lines) 
	
func growBoth(): # Growing the sunflowers after the radishes
	await grow("Radish")
	await get_tree().create_timer(randf_range(0.8,1.2)).timeout
	await grow("Sunflower")

	
func grow(group): # Grow animation
	var plants = get_tree().get_nodes_in_group(group) # Get the radish or sunflower group
	plants.shuffle() # Plant in random order
	for node in plants: # Loop through group
		if node is Radish or node is Sunflower: # 
			node.grow() # Run the grow animation
			await get_tree().create_timer(randf_range(0.8,1.2)).timeout # Time between each being planted



func _on_if_plant_correct_input():
	finished = true # The level can now be exited
	$ChestGlint.visible = false
	$ExitGlint.visible = true


func _on_chest_interacted(): # Console appears on interaction and player can't move
	$IfPlant.visible = true
	Global.playerStop($Player, true)


func _on_if_plant_close_pressed(): 
	$IfPlant.visible = false 
	Global.playerStop($Player, false) 
	if finished: # If console input is correct
		growBoth() # Grow animation played

func _on_exit_body_entered(body): 
	if body is Player && finished:
		$ConfirmExit.visible = true
		Global.playerStop($Player, true)

func _on_confirm_exit_no(): 
	Global.playerStop($Player, false) 

func _on_if_plant_wrong_input():
	finished = false 


func _on_if_plant_run_pressed(_outlines):
	runCount +=1 


func _on_tree_exited(): 
	if finished: # If the user code was correct, stats are updated
		Global.setStats('Level1',$LevelTimer/Label.text,str(runCount))
