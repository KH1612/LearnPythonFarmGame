extends Node2D
class_name Radish
@onready var sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Radish") # Added to radish group 
	sprite.play("idle") # Play idle animation
	
func grow(): # Will grow when called
	sprite.play("grow")


