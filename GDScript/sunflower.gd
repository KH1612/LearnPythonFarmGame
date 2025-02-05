extends Node2D
class_name Sunflower
@onready var sprite = $AnimatedSprite2D

func _ready():
	# Added to sunflower group and idle
	add_to_group("Sunflower") 
	sprite.play("idle") 
func grow(): # Will grow when called
	sprite.play("grow")



