extends Control

signal no

func _process(_delta):
	if Input.is_action_just_pressed("pop_options"): 
		# Can press escape to open any time to quit but stats wont be saved if finished is false
		visible = true
	
func _on_yes_pressed(): # If yes pressed then return to level select
	get_tree().change_scene_to_file("res://Scences/level_selector.tscn")

func _on_no_pressed(): # Closes the control and emits no signal so other classes can act
	emit_signal("no")
	visible = false


