extends MarginContainer

signal finished_displaying()

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer


const MAX_WIDTH = 256
var text = ""
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

func display_text(text_to_display: String):
	print("Displaying text: ", text_to_display)  # Debugging
	letter_index = 0
	text = text_to_display
	label.text = ""  # Clear the label before displaying the new text

	# Auto-wrap text if width exceeds the maximum
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		custom_minimum_size.y = size.y
	
	# Adjust global position to be centered
	global_position.x -= size.x * 2 + 100
	global_position.y -= 70
	
	# Start displaying letters
	_display_letter()

func _display_letter():
	if letter_index >= text.length():
		finished_displaying.emit()  # Emit signal once all letters are shown
		return
	
	# Add the current letter to the label's text
	label.text += text[letter_index]
	letter_index += 1  # Move to the next letter
	
	# Match punctuation and spaces for timing control
	match text[letter_index - 1]:
		",", ".", "!", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

# Timer callback to handle displaying the next letter
func _on_letter_display_timer_timeout():
	_display_letter()
