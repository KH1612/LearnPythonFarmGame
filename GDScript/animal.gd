extends CharacterBody2D


var SPEED = 0
var dir = Vector2.LEFT
var rng = RandomNumberGenerator.new()
var waitTime = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	$Timer.wait_time = rng.randf_range(3,4)
	var dirs = [Vector2.LEFT, Vector2.RIGHT]
	dirs.shuffle()
	dir = dirs[0]


func _process(delta): # Always playing move
	move(delta)

func move(delta): # Changes position based on frames, direction and speed
	position += dir * SPEED * delta


func _on_timer_timeout(): # When the timer is finished

	if dir == Vector2.RIGHT: # Direction change
		dir = Vector2.LEFT
		if SPEED == 0: # If not moving then wait
			await get_tree().create_timer(rng.randf_range(1,3)).timeout
		# Play animations
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D.flip_h = false
		
		
	else :
		dir = Vector2.RIGHT
		if SPEED == 0:
			await get_tree().create_timer(rng.randf_range(0.5,2)).timeout
		# Reverse animation based on direction
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D.flip_h = true
		


# Default values depending on which sub class is running
func _on_animated_sprite_2d_blink():
	SPEED = 0
	waitTime = 1


func _on_animated_sprite_2d_sheep():
	SPEED = randi_range(10,13)
	waitTime = randf_range(4,5)


func _on_animated_sprite_2d_chicken():
	SPEED = randi_range(8,11)
	waitTime = randf_range(4,5)


func _on_animated_sprite_2d_cow():
		SPEED = randi_range(10,13)
		waitTime = randf_range(4,5)
