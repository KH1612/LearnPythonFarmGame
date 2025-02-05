extends Node2D
var scroll_speed: Vector2 = Vector2(20,0) # Speed the background scrolls at
func _process(delta):
	$ParallaxBackground.scroll_offset -= scroll_speed *delta # Scrolls based on frames

func _ready():
	Global.loadGame() # Load previous data
	Global.saveGame() # Init into Global or create a new save file if doesn't exist
	
func _on_start_pressed(): # Open level select screen
	get_tree().change_scene_to_file("res://Scences/level_selector.tscn")

func _on_options_pressed(): # Go to options screen
	get_tree().change_scene_to_file("res://Scences/options_menu.tscn")

func _on_exit_pressed(): # Exit game
	get_tree().quit()
