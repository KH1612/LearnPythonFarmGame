extends Area2D

var showLabel = false
signal interacted
# Called when the node enters the scene tree for the first time.
func _ready():
	$AppleBox/Apples.visible = false
	$OrangeBox/Oranges.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.visible = showLabel
	if Input.is_action_just_pressed("e_pressed") && showLabel:
		emit_signal("interacted")


func _on_body_entered(body):
	if body is Player:
		showLabel = true


func _on_body_exited(body):
	if body is Player:
		showLabel = false

func fruitPlaced():
	$AppleBox/Apples.visible = true
	$OrangeBox/Oranges.visible = true
