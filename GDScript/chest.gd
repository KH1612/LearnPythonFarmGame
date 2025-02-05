extends Area2D

# Boolean to track if the label needs to be shown
var showLabel = false

# Signal for other classes to see when chest is interacted with
signal interacted 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.visible = showLabel # Always checking if the label needs to be shown
	if Input.is_physical_key_pressed(KEY_E) && showLabel: # If 'e' is pressed and label is true then play the open animation
		$AnimatedSprite2D.play("open") 
		emit_signal("interacted")
	elif !showLabel: # Play the close animation when the player leaves the interaction zone
		$AnimatedSprite2D.play("closed")


func _on_body_entered(body):
	if body is Player: # Show the label when the player enters the interaction zone
		showLabel = true


func _on_body_exited(body):
	if body is Player: # Hide the label when the player leaves the interaction zone
		showLabel = false
