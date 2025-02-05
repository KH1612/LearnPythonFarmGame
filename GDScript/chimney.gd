extends Area2D

var showLabel = false
signal interacted



func _process(_delta):
	$Label.visible = showLabel # Always checking if the label needs to be shown
	if Input.is_physical_key_pressed(KEY_E) && showLabel: # If 'e' is pressed and label is true then play the open animation
		emit_signal("interacted")

func _on_body_entered(body):
		if body is Player: # Show the label when the player enters the interaction zone
			showLabel = true


func _on_body_exited(body):
		if body is Player: # Hide the label when the player leaves the interaction zone
			showLabel = false
