extends Area2D

signal interacted
signal mined



func _on_chest_interacted():
	emit_signal("interacted") # Signal when the chest is interacted with



func _on_diamond_1_mining():
	emit_signal("mined")


func _on_diamond_2_mining():
	emit_signal("mined")


func _on_gold_1_mining():
	emit_signal("mined")


func _on_gold_2_mining():
	emit_signal("mined")


func _on_gold_3_mining():
	emit_signal("mined")


func _on_coal_1_mining():
	emit_signal("mined")
