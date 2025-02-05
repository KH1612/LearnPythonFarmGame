extends Node2D

var harvestable = false
var harvested = false
var finished = false
var fruitNum = 0
var readyToPlace = false
var runCount = 0

var dialog_lines: Array[String] = []
@onready var npc = $NPC

func _ready():
	# Assigning correct python scripts to console and hit text
	$Harvest.pyScript = "Level4_Harvest.py" 
	
	$Harvest/ColorRect/PyScript.text = "# You are given an empty array bag
bag =[]
# You are also given a Collect function that adds a fruit 
# to the bag array which is passed as a parameter
def Collect(bag):
	bag.append('Fruit')
	
# Your job is to complete the Hit function below 
def Hit():
	# Assign a string value 'axe' to a variable tool

	# Print the string 'Tree has been hit'

	# Call the above collect function (with the parameter)

# Write a for loop that runs 8 times which calls the Hit() function
# at every iteration

# Now go harvest the fruit from the trees"

	$Place.pyScript = "Level4_Place.py"
	
	$Place/ColorRect/PyScript.text = "# Have been given the following arrays
bag = ['apple', 'apple','apple', 'apple','orange','orange','orange','orange']
appleBox = []
orangeBox =[]
# Complete the following function to move the fruits from
# the bag into each specific box (array)
def Place():
	# Write a for loop to iterate through the bag array

		# Write an if else to check whether each index is an apple or
		# an orange and append them to the correct box




# Call your place function here


print(appleBox) # Output the apple box
print(orangeBox)# Output the orange box"

	# User dialogue and dialogue manager processing
	dialog_lines = [
	"Good to see you " + Global.getName(),
	"We're going to be harvesting some fruit from those trees.",
	"You're going to need to code a function to do this",
	"You then need to make another function with an if else",
	"statement to put the each fruit in the correct box",
	"Everything you need is in that chest over there"
	]
	
	npc.set_dialog(dialog_lines)


func _on_chest_interacted(): # Console opened on iteract
	$Harvest.visible = true
	Global.playerStop($Player, true)


func _on_harvest_correct_input(): # Pathing changed on correct input 
	$ChestGlint.visible = false
	harvestable = true # Can progress to next phase
	var fruit = get_tree().get_nodes_in_group("Fruit")
	for node in fruit: # All fruit trees can now be harvested
		if node is Fruit:
			node.harvestable = true

func _on_harvest_close_pressed(): # Console closed on close pressed, player can move
	$Harvest.visible = false
	Global.playerStop($Player, false)
	

func fruitCollect(): # Checking if all fruit have been collected
	fruitNum +=1
	if fruitNum == 8:
		readyToPlace = true # Can progress to next phase and pathing change
		$BoxGlint.visible = true
	

func _on_fruit_boxes_interacted():
	if readyToPlace: # If previous code done
		$Place.visible = true # Console shown and can't move
		Global.playerStop($Player, true)


func _on_place_close_pressed(): # Close pressed, hidden console, can move
	$Place.visible = false
	Global.playerStop($Player, false)


func _on_place_correct_input():
	$FruitBoxes.fruitPlaced() # Play fruit in the boxes animation
	finished = true # Can exit level and user pathing changed
	$BoxGlint.visible = false
	$exitGlint.visible = true

func _on_place_wrong_input():
	finished = false # Can't exit level
	
# Making sure all fruit has been collected
func _on_apple_tree_1_interacted():
	fruitCollect()


func _on_apple_tree_2_interacted():
	fruitCollect()


func _on_apple_tree_3_interacted():
	fruitCollect()


func _on_apple_tree_4_interacted():
	fruitCollect()

func _on_orange_tree_1_interacted():
	fruitCollect()


func _on_orange_tree_2_interacted():
	fruitCollect()


func _on_orange_tree_3_interacted():
	fruitCollect()


func _on_orange_tree_4_interacted():
	fruitCollect()


func _on_exit_body_entered(body): 
	$ConfirmExit.visible = true
	Global.playerStop($Player,true)

func _on_confirm_exit_no(): 
	Global.playerStop($Player,false)

# Increasing runCount based on run pressed amount
func _on_harvest_run_pressed(_outlines):
	runCount +=1


func _on_place_run_pressed(_outlines):
	runCount +=1

func _on_tree_exited(): # Progress saved on close if all code correct
	if finished:
		Global.setStats('Level4',$LevelTimer/Label.text,str(runCount))

