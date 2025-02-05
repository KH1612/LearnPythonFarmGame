extends Area2D
class_name egg # Reference to other classes

var showLabel = false
var collectable
signal interacted
# Called when the node enters the scene tree for the first time.

func _ready():
	add_to_group("Eggs") # Add to egg group

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.visible = showLabel # Always checking if the label needs to be shown
	if Input.is_action_just_pressed("e_pressed") && showLabel && collectable: # If 'e' is pressed and label is true then play the open animation
		emit_signal("interacted")

func _on_body_entered(body):
	if body is Player: # Show the label when the player enters the interaction zone
		showLabel = true

func _on_body_exited(body):
	if body is Player: # Hide the label when the player leaves the interaction zone
		showLabel = false


func _on_interacted(): # Dissapears on interact
	visible = false
