extends HSlider

@export
var busName: String
var busIndex: int 


# Called when the node enters the scene tree for the first time.
func _ready():
	busIndex = AudioServer.get_bus_index(busName) # Gets index of audio bus that needs changing
	value_changed.connect(_on_value_changed) # Value changes when slider changes
	
	value = db_to_linear(AudioServer.get_bus_volume_db(busIndex)) # Linear sound conversion



func _on_value_changed(value): # Signal when slider changed
	AudioServer.set_bus_volume_db(busIndex,linear_to_db(value)) # Changes audio level
