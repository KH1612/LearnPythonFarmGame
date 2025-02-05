extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect/Name.text = Global.getName() # Assigns saved player name to the textbox

func _on_fullscreen_slide_toggled(toggled_on): 
	if toggled_on == true:# If the fullscreen slider is toggled
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED) # Maximise the screen
	else: # Otherwise
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) # Stay in normal viewport

func _on_return_pressed(): # Return to main menu
	get_tree().change_scene_to_file("res://Scences/main.tscn")


func _on_confirm_pressed(): # When the confirm button is pressed
	Global.setName($TextureRect/Name.text) # The global name is changed to the user input
	showMessage($TextureRect/nameMsg) # Message to tell the user name has been set pops up

func _on_reset_pressed(): # When the reset button is pressed
	Global.Reset() # The rest of the stats dictionary is done
	showMessage($TextureRect/resetMsg) # User prompted that this action is confirmed

func showMessage(label : Label): # Takes a label to show the message on
	# The label is visible for 1 second
	label.visible = true 
	await get_tree().create_timer(1).timeout
	label.visible = false
