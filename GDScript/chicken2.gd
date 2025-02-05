extends CharacterBody2D
# Different states
var eating = false
var walking = false

var xdir = 1
var ydir = 1
var speed = 5

var motion = Vector2()

var moving_vertical_horizontal = 1

func _ready():
	walking = true
	randomize() 

func _physics_process(delta): # Always checking state
	# Reset motion to avoid old values persisting
	motion = Vector2.ZERO
	# Playing animation based on randomiser functions 
	if not walking:
		var x = randi_range(1, 2)
		if x > 1.5:
			moving_vertical_horizontal = 1
		else:
			moving_vertical_horizontal = 2
			
	if walking:
		$AnimatedSprite2D.play("walking")
		
		if moving_vertical_horizontal == 1:
			if xdir == -1:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
			motion.x = speed * xdir
			motion.y = 0
		elif moving_vertical_horizontal == 2:
			motion.y = speed * ydir
			motion.x = 0
			
	if eating:
		$AnimatedSprite2D.play("eating")
		motion = Vector2.ZERO
	
	# Assign the motion to the velocity
	velocity = motion
	move_and_slide() # Call movement

func _on_changestatetimer_timeout(): # Changes state on timer runout
	var waittime = 1
	if walking:
		eating = true
		walking = false
		waittime = randi_range(1, 5)
	elif eating:
		walking = true
		eating = false
		waittime = randi_range(2, 6)
		
	$changestatetimer.wait_time = waittime
	$changestatetimer.start()

func _on_walkingtimer_timeout(): # Change direction based on timeout then restart
	var x = randi_range(1, 2)
	var y = randi_range(1, 2)
	var waittime = randi_range(1, 4)

	if x > 1.5:
		xdir = 1
	else:
		xdir = -1

	if y > 1.5:
		ydir = 1
	else:
		ydir = -1
		
	$walkingtimer.wait_time = waittime
	$walkingtimer.start()

	
	
	

