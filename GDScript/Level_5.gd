extends Node2D

var finished = false
var inventory = false
var lamps = false
var mining = false
var minedCount = 0
var dialog_lines: Array[String] = []
@onready var npc = $NPC
var runCount = 0

func smelt(rock : mineral): # Smelting logic and animation play
	rock.visible = true
	rock.showLabel = false
	rock.minable = false
	rock.position = Vector2(830,360)
	rock.play("furnace")
	await get_tree().create_timer(1.5).timeout
	rock.visible = false 

func mineCount(): # Check if all rocks have been mined
	minedCount +=1
	if minedCount == 6:
		mining = true
		$SmeltGlint.visible = true
		$MineGlint.visible = false


func _ready():
	dialog_lines = [
	"Lucky you " + Global.getName() +"!", 
	"We've found some gold and diamonds in this cave under the farm",
	"You will need to use the programming knowledge you've learnt",
	"so far, to mine and smelt the rocks",
	"But firstly, you need get your equipment from the chest",
	"then light up the cave using your matches",
	"Then you can go to the chest to prepare for mining the rocks",
	"before smelting them into minerals",
	"This is the last level of the game so we hope you have ",
	"developed a better understanding of basic programming and",
	"have had fun doing so. More levels may be developed based",
	"on the feedback of our supervisors!",
	"Thank you!"
	]
	npc.set_dialog(dialog_lines)
	
	$LampGlint.visible = false
	$DarkenScene.visible = true
	
	$Inventory.pyScript = "Level5_Inventory.py"
	$LampLight.pyScript = "Level5_LampLight.py"
	$Mining.pyScript = "Level5_Mining.py"
	$Smelting.pyScript = "Level5_Smelt.py"
	
	
	$Inventory/ColorRect/PyScript.text = "# Fill your inventory with tools needed for this mission
# Write an array of strings which contains: pickaxe, bag, matches

# Proceed to the lamps"

	$LampLight/ColorRect/PyScript.text = "# Use the matches to turn on the lamps
# Using your inventory array, assign matches (2nd array index)
# to a variable 'tool'
# hint: use the pop function

# Proceed to chest"

	$Mining/ColorRect/PyScript.text = "# Your inventory is available (inventory = ['pickaxe', 'bag'])
# Complete the mine function below
# The function must take 1 parameter which is your inventory array
def mine( ): # Parameter goes here
	# Assign the tool variable to pickaxe using array indexing (0th index) of inventory

	# Call the premade function hit() which takes 1 parameter (tool)

	# Now reassign the tool variable to bag (1st index) of inventory

	# Call the premade function collect() which also takes the parameter tool

#Call your function below

#Now walk up to and mine the rocks"

	$Smelting/ColorRect/PyScript.text = "# Write a for loop to iterate through your bag array containing the ores

	# Write an if elif else block to sort the minerals
	# If the mineral is gold
		# Print: Gold has been smelted


	# elif the mineral is diamond
		# Print: Diamond has been smelted


	# Else
		# Print: Coal is in the furnace"

func _on_chest_interacted():
	$Inventory.visible = true
	Global.playerStop($Player, true)


func _on_inventory_close_pressed():
	$Inventory.visible = false
	Global.playerStop($Player, false)

func _on_inventory_correct_input():
	$LampGlint.visible = true
	$ChestGlint.visible = false
	inventory = true # Next phase

func _on_lamps_body_interacted():
	if inventory:
		$LampLight.visible = true
		Global.playerStop($Player, true)

func _on_lamp_light_close_pressed():
	$LampLight.visible = false
	Global.playerStop($Player, false)

func _on_lamp_light_correct_input(): # Switch on the lights on correct input
	$DarkenScene.visible = false
	$Lamps_Body/Lamp1/AnimatedSprite2D.play("on")
	$Lamps_Body/Lamp2/AnimatedSprite2D.play("on")
	$MineGlint.visible = true
	$LampGlint.visible = false
	lamps = true # Next phase

func _on_lamp_light_wrong_input(): # Turn off lights on incorrect input
	$DarkenScene.visible = true
	$Lamps_Body/Lamp1/AnimatedSprite2D.play("off")
	$Lamps_Body/Lamp2/AnimatedSprite2D.play("off")


func _on_mining_area_interacted():
	if lamps:
		Global.playerStop($Player, true)
		$Mining.visible = true

func _on_mining_close_pressed():
	$Mining.visible = false
	Global.playerStop($Player, false)


func _on_mining_correct_input():
	var minerals = get_tree().get_nodes_in_group("Minerals")
	for node in minerals: # Make all the rocks minable on correct input
		if node is mineral:
			node.minable = true

func _on_mining_area_mined():
	mineCount() # When each rock is mined check count

func _on_furnace_interacted():
	if mining:
		Global.playerStop($Player, true)
		$Smelting.visible = true


func _on_smelting_close_pressed():
	Global.playerStop($Player, false)
	$Smelting.visible = false
	
	if finished:
		Global.playerStop($Player,true)
		var minerals = get_tree().get_nodes_in_group("Minerals")
		minerals.shuffle() # Play in random order
		for node in minerals:
			if node is mineral:
				smelt(node) # Play the smelt animation
				await get_tree().create_timer(2).timeout
		Global.playerStop($Player,false)


func _on_smelting_correct_input(): # Can finish level
	finished = true
	$Furnace/Furnace/Smoke.play("default")
	$SmeltGlint.visible = false
	$ExitGlint.visible = true

func _on_exit_body_entered(body):
	if body is Player && finished:
		$ConfirmExit.visible = true
		Global.playerStop($Player, true)

func _on_confirm_exit_no():
	Global.playerStop($Player, false)
	
# Inc run count
func _on_inventory_run_pressed(_outlines):
	runCount+=1


func _on_lamp_light_run_pressed(_outlines):
	runCount+=1


func _on_mining_run_pressed(_outlines):
	runCount+=1


func _on_smelting_run_pressed(_outlines):
	runCount+=1

func _on_tree_exited():
	if finished:
		Global.setStats('Level5',$LevelTimer/Label.text,str(runCount))




