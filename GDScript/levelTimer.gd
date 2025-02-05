extends Label

var time = 0

func _on_timer_timeout():
	time +=1
	text = str(time)
