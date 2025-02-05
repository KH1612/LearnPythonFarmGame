extends AnimatedSprite2D

signal blink
var rng = RandomNumberGenerator.new()
func _ready():
	
	emit_signal("blink")



