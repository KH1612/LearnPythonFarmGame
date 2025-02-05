extends Area2D
class_name Fruit
var harvestable = false
var harvested = false
var showLabel = false
var player : Player
signal interacted
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("start")
	add_to_group("Fruit") # Add to fruit group

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !harvested: # If not interacted with then can show label
		$Label.visible = showLabel
		
	if !harvested && harvestable: # If state is harvestable, can be chopped
		if Input.is_action_just_pressed("e_pressed") && showLabel:
			emit_signal("interacted")
			chopped() # Play chopped animation

func chopped():
	$Label.visible = false
	Global.playerStop(player, true) # Cant move during animation
	harvested = true
	player.Harvest() # Player harvesting animation
	await get_tree().create_timer(randf_range(2.3,2.8)).timeout # Wait
	$AnimatedSprite2D.play("end") # Last animation of the fruit tree
	player.Collect() # Collect player animation playing
	await get_tree().create_timer(randf_range(2.3,2.8)).timeout # Wait
	Global.playerStop(player, false) # Can move again
	visible = false # Invisible as if collected
	$StaticBody2D/CollisionShape2D.disabled = true # Can't collide
	
	


func _on_body_entered(body):
	if body is Player: 
		player = body # Saves the player so can be interacted with
		showLabel = true


func _on_body_exited(body): 
	if body is Player:
		showLabel = false
