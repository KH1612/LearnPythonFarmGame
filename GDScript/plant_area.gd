extends Area2D
var showLabel = false
var doing = false
signal interacted
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !doing: # While animation not playing
		$Label.visible = showLabel # Always checking if the label needs to be shown
	if Input.is_physical_key_pressed(KEY_E) && showLabel: # If 'e' is pressed and label is true then play the open animation
		emit_signal("interacted")
		doing = true
		$Label.visible = false
		



func _on_body_entered(body):
	if body is Player: # If player in body, show the label
		showLabel = true


func _on_body_exited(body):
	if body is Player: # Otherwise hide label
		showLabel = false
