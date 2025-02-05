extends CharacterBody2D
class_name Player # Name of this class to other classes

# Original player attributes
const SPEED = 200
var direction = "none"
var stopped = false
var mineDir = "none"

func _ready():
	$AnimatedSprite2D.play("backIdle")
	
func _physics_process(delta):
	playerMove(delta)

func playerMove(_delta):
	# Vectors assigned that change position of sprite based on pressing the arrow keys, changes direction and plays the correct animation
	if !stopped:
		if Input.is_action_pressed("ui_right"):
			direction= "right"
			animation(1)
			velocity.x= SPEED
			velocity.y=0
		elif Input.is_action_pressed("ui_left"):
			direction= "left"
			animation(1)
			velocity.x= -SPEED
			velocity.y=0
		elif Input.is_action_pressed("ui_up"):
			direction= "up"
			animation(1)
			velocity.x= 0
			velocity.y= -SPEED
		elif Input.is_action_pressed("ui_down"):
			direction= "down"
			animation(1)
			velocity.x= 0
			velocity.y= SPEED
		else:
			animation(0)
			velocity.x= 0
			velocity.y= 0
		move_and_slide()
	
func animation(move):
	# Assigning variables to be used in the method
	var dir = direction
	var anim = $AnimatedSprite2D
	# Plays the correct animation based on the move state and direction
	if dir == "right":
		anim.flip_h = false
		if move == 1:
			anim.play("sideRun")
		elif move == 0:
			anim.play("sideIdle")
			
	if dir == "left":
		anim.flip_h = true
		if move == 1:
			anim.play("sideRun")
		elif move == 0:
			anim.play("sideIdle")
			
	if dir == "up":
		anim.flip_h = true
		if move == 1:
			anim.play("backRun")
		elif move == 0:
			anim.play("backIdle")

	if dir == "down":
		anim.flip_h = true
		if move == 1:
			anim.play("frontRun")
		elif move == 0:
			anim.play("frontIdle")

func Mine(): # Mine animation to play based on direction 
	if mineDir == "bottom":
		$AnimatedSprite2D.play("backMine")
	elif mineDir == "top":
		$AnimatedSprite2D.play("frontMine")
	elif mineDir == "right":
		$AnimatedSprite2D.play("sideMine")
	elif mineDir == "left":
		$AnimatedSprite2D.play("sideMine")
	
func Harvest(): # Harvest animation play
	$AnimatedSprite2D.play("axe")

func Collect(): # Collect animation played with position change
	position.y -=10
	position.x +=10
	$AnimatedSprite2D.play("collect")
