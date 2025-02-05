extends Node  

# Preload the text box scene that will display dialog
@onready var text_box_scene = preload("res://Scences/text_box.tscn")

# Variables to store dialog lines, current line index, and the text box instance
var dialog_lines: Array[String] = []  # Stores the lines of dialog
var current_line_index = 0  # Tracks the current line of dialog being displayed
var text_box  # Holds the instance of the text box
var text_box_position: Vector2  # Stores the position where the text box should be displayed
var is_dialog_active = false  # Tracks if a dialog is currently active
var can_advance_line = false  # Determines if the player can advance to the next line of dialog

# Signal emitted when the dialog is finished
signal dialog_finished()

# Starts a dialog sequence with the specified position and lines
func start_dialog(position: Vector2, lines: Array[String]):  
	if is_dialog_active:  # If a dialog is already active, do nothing
		return
	dialog_lines = lines  # Set the dialog lines
	text_box_position = position  # Set the position for the text box

	_show_text_box()  # Show the text box with the first line

	is_dialog_active = true  

# Internal function to show the text box and display the current line
func _show_text_box():  
	text_box = text_box_scene.instantiate()  # Create an instance of the text box
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)  # Connect the signal for when the text is done displaying
	get_tree().root.add_child(text_box)  # Add the text box to the scene
	text_box.global_position = text_box_position  # Set the position of the text box
	text_box.display_text(dialog_lines[current_line_index])  # Display the current line of dialog
	can_advance_line = false  # Prevent advancing the dialog until the text is fully displayed

# Callback when the text box has finished displaying the current line
func _on_text_box_finished_displaying():  
	can_advance_line = true  

# Handle player input to advance the dialog
func _unhandled_input(event):  
	if (event.is_action_pressed("advance_dialog") and is_dialog_active and can_advance_line):  # Check if the advance button is pressed and dialog can proceed
		text_box.queue_free()  # Remove the current text box

		current_line_index += 1  # Move to the next line
		if current_line_index >= dialog_lines.size():  # If all lines are done
			is_dialog_active = false  # Mark the dialog as inactive
			current_line_index = 0  # Reset the line index
			dialog_finished.emit()  # Emit the dialog finished signal
			return

		_show_text_box()  # Show the next line in a new text box
