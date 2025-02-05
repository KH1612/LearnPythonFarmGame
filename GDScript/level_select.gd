extends Control

func _ready():
	Global.loadGame() # Load stats on startup
	
	
func _on_level_0_pressed(): # Go to level 0
	get_tree().change_scene_to_file("res://Scences/Level_0.tscn")

func _on_level_1_pressed(): # Go to level 1
	get_tree().change_scene_to_file("res://Scences/Level_1.tscn")


func _on_level_2_pressed():# Go to level 2
	get_tree().change_scene_to_file("res://Scences/Level_2.tscn")


func _on_level_3_pressed():# Go to level 3
	get_tree().change_scene_to_file("res://Scences/Level_3.tscn")


func _on_level_4_pressed():# Go to level 4
	get_tree().change_scene_to_file("res://Scences/Level_4.tscn")


func _on_level_5_pressed():# Go to level 5
	get_tree().change_scene_to_file("res://Scences/Level_5.tscn")

func _on_main_menu_pressed():# Go to main menu
	get_tree().change_scene_to_file("res://Scences/main.tscn")

func _on_tree_entered(): #When this scene is loaded
	
	Global.saveGame() # Save changes to dictionary
	Global.loadGame() # Loads latest values
	
	# Setting the updated stats to each level stats scene 
	setStats($LevelStats0,Global.savedStats['Level0'])
	setStats($LevelStats1,Global.savedStats['Level1'])
	setStats($LevelStats2,Global.savedStats['Level2'])
	setStats($LevelStats3,Global.savedStats['Level3'])
	setStats($LevelStats4,Global.savedStats['Level4'])
	setStats($LevelStats5,Global.savedStats['Level5'])
	
func setStats(level : LevelStats, stats): # Takes in the level and array from dictionary
	level.setTime(stats[0]) # Set the time taken for the level
	level.setRunCount(stats[1]) # Set the number of times run was pressed

