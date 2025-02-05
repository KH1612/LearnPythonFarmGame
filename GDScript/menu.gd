extends Control

#Opens the level selector on button press
func _ready():
	Global.loadGame()
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scences/level_selector.tscn")

#Opens the option menu on press
func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scences/options.tscn")

#Exits the game
func _on_exit_pressed():
	get_tree().quit()


