extends Node2D 

var farmName
var nameCorrect = false # Correct console code
var finished = false # User can exit level
var runCount = 0 # How many times has run been pressed
# Needed for npc dialogue
var dialog_lines: Array[String] = [] 
@onready var npc = $NPC

func _ready(): # On load
	$ChestGlint.visible = true # Tells the player where to go
	$AssignName.pyScript = "Level0_AssignName.py" # Assigning correct python script to console class
	# Text given in the console
	$AssignName/ColorRect/PyScript.text = "# Lines starting with '#' won't be exexuted as they are comments
# Write your farm name in the quotes to assign it to the variable 'name'
# Variable assignment: variable = value where value will be saved into variable
name = ' ' 
# Write the variable 'name' into the print function
print()
# Interact with the sign to check your output
# Walk to the end of the path to complete the level"
	
	
	dialog_lines = [ # Dialogue lines given for the npc
	"Welcome " + Global.getName() + ", press 'Enter' to skip text",
	"Your goal is to write code to help out on the farm",
	"Your level stats are tracked by time and the number",
	"of code runs per level",
	"Your job for this level is to write your farm's name",
	"in a print statement. All the supplies are in the chest",
	"Follow the flashing light on the floor for your next objective",
	"Press the 'esc' key to leave a level early",
	"You can also rename yourself in the options menu on the home screen",
	"Remember that every programmers best friend is google so keep that",
	"in mind as you progress through the levels",
	"Enjoy!"
	]
	
	npc.set_dialog(dialog_lines) # Lines processed in the dialogue manager

func _on_chest_interacted(): # On chest interaction, the console appears and player can't move
	Global.playerStop($Player, true) 
	$AssignName.visible = true
	

func _on_assign_name_close_pressed(): # On console close, console dissapears and player can move again
	$AssignName.visible = false
	Global.playerStop($Player, false)
		

func _on_assign_name_run_pressed(outlines): # On run pressed
	runCount +=1 # Inc runcount

func _on_assign_name_wrong_input():
	finished = false # Cant progress with a wrong input


func _on_assign_name_correct_input():
	finished = true
	# User pathing changed
	$ChestGlint.visible = false
	$EndGlint.visible = true


func _on_exit_body_entered(body): # If the player is in the exit body and exit conditions are met then the exit screen is visible
	if body is Player && finished: # 
		$ConfirmExit.visible = true
		Global.playerStop($Player, true)

func _on_confirm_exit_no(): # On no pressed, this signal is also handled in another class
	Global.playerStop($Player, false) # Player can move again on exit screen no pressed
	
func _on_tree_exited():
	if finished: # If the level is exited and the user has finished it, their stats are updated
		Global.setStats('Level0',$LevelTimer/Label.text,str(runCount))

