extends Area2D  # Extends Node2D to control a 2D game object with interaction capabilities

# Reference the label from the InteractionManager node, assuming it's in the parent node

var showLabel = false
signal interacted


# Reference the InteractionArea and sprite nodes
@onready var sprite = $AnimatedSprite2D  # Main character sprite
@onready var sprite_hair = $AnimatedSprite2D2  # Hair sprite for the character

# Array to store lines of dialog, can be set by the parent scene
var lines: Array[String] = []  

# Function to set dialog lines, allowing the parent scene to pass in an array of strings
func set_dialog(line: Array[String]):  
	lines = line  # Assign the passed lines to the internal lines array


# Ready function that is called when the node is added to the scene
func _ready():  
	sprite.play("idle")  # Play the idle animation for the main sprite
	sprite_hair.play("idle")  # Play the idle animation for the hair sprite

func _process(_delta):
	$Label.visible = showLabel # Always checking if the label needs to be shown
	if Input.is_physical_key_pressed(KEY_E) && showLabel: # If 'e' is pressed and label is true then play the open animation
		emit_signal("interacted")

func _on_body_entered(body):
	if body is Player:
		showLabel = true


func _on_body_exited(body):
	if body is Player:
		showLabel = false


func _on_interacted():
	DialogManager.start_dialog(global_position, lines)  # Start the dialog at the character's position with the provided lines
	await DialogManager.dialog_finished  
