extends Area2D


var showLabel = false
signal interacted
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpeechBubble.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.visible = showLabel # Always checking if the label needs to be shown
	if Input.is_physical_key_pressed(KEY_E) && showLabel: # If 'e' is pressed and label is true then play the open animation
		$SpeechBubble.visible = true
		emit_signal("interacted")
		showLabel = false

func _on_body_entered(body):
	if body is Player: # Show the label when the player enters the interaction zone
		showLabel = true


func _on_body_exited(body):
	if body is Player: # Hide the label when the player leaves the interaction zone
		showLabel = false
		$SpeechBubble.visible = false
