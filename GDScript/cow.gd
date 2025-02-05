extends AnimatedSprite2D

signal cow

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("cow")


