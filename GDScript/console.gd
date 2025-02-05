extends Control

var DIR = OS.get_executable_path().get_base_dir() # Executable path
var pyScript = "TestSpace.py" # Default value
var localInterpreter = "res://PY/Environment/Scripts/python.exe"
var localScript = "res://PY/" # Script to be added
var interpreter_path = DIR.path_join(localInterpreter) #Interpreter path
var script_path = DIR.path_join(localScript) #Python script path



# Signal to tell other classes that the close button has been pressed
signal closePressed 
signal runPressed(outlines)
signal wrongInput
signal correctInput
func _on_clear_pressed(): # Reset output box when clear is pressed
	$ColorRect/Output.text = "Output: \n"


func _on_run_pressed():
	if !OS.has_feature("standalone"): # if NOT exported version (Used for running during testing in the editor
		interpreter_path = ProjectSettings.globalize_path(localInterpreter)
		script_path = ProjectSettings.globalize_path(localScript + pyScript)
	else:  
		script_path += pyScript # Add python script to path
	var output = [] 
	OS.execute(interpreter_path, [script_path, $ColorRect/PyScript.text], output) #Execute the users code in the python script
	var out = output[0]
	var outlines = out.split("\n")
	var correct = true
	for line in outlines:
		if 'wrong' in line: # Filter out developer signals
			print(line)
			emit_signal("wrongInput")
			correct = false
		else:
			$ColorRect/Output.text += line + "\n" # Print user output
		
	if correct:
		emit_signal('correctInput') # Signal correct if user code is correct

	emit_signal("runPressed",outlines) # On run pressed

func _on_close_pressed():
	emit_signal("closePressed") # Tell other classes the close button is pressed

