extends Control
class_name LevelStats # Reference to other classes

func setTime(time):
	if time != null: # If time isn't null
		$Time.text = time # Assign time to the time label

func setRunCount(runCount):
	if runCount != null: # If runCount isn't null
		$Runs.text = runCount # Assign runCount to Runs label
