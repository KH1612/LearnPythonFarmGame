extends AnimatedSprite2D
class_name mineral
var showLabel = false
var minable = false
var mined = false
signal interacted
signal mining
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Minerals")
	$Label.visible = showLabel
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if minable:
		$Label.visible = showLabel
		if Input.is_action_just_pressed("e_pressed") && showLabel:
			emit_signal("interacted")


func _on_area_2d_body_entered(body):
	player = body
	if body is Player && !mined: # Hide the label when the player leaves the interaction zone
		showLabel = true
		var pos = body.position-position
		if pos is Vector2:
			if pos.x > pos.y && pos.x > 0 && pos.y>0:      # right direction (if x > y and x is positive)
				body.mineDir = "right"
			elif pos.x < pos.y && pos.x < 0:    # left direction (if x < y and x is negative)
				body.mineDir = "left"
			elif pos.y > pos.x && pos.y > 0:    # bottom direction (if y > x and y is positive)
				body.mineDir = "bottom"
			elif pos.y < pos.x && pos.y < 0:    # top direction (if y < x and y is negative)
				body.mineDir = "top"
	


func _on_area_2d_body_exited(body):
	if body is Player: # Hide the label when the player leaves the interaction zone
		showLabel = false


func _on_interacted():
	showLabel = false
	Global.playerStop(player, true)
	if player is Player:
		player.Mine()
	emit_signal("mining")
	await get_tree().create_timer(randf_range(1.5,3)).timeout
	play("middle")
	await get_tree().create_timer(randf_range(1.5,3)).timeout
	play("end")
	await get_tree().create_timer(randf_range(1.5,3)).timeout
	visible = false
	Global.playerStop(player, false)
	$StaticBody2D/CollisionShape2D.disabled = true
