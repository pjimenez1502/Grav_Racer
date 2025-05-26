extends Area3D
class_name Stopwatch

var current_lap : int = 0
var current_stopwatch : float

var lap_history : Array[float]

func _physics_process(delta: float) -> void:
	current_stopwatch += delta

func on_start_line_pass(area: Area3D) -> void:
	## When interacting with start line detector
	## Save previous lap time on lap_history (CHECK IF LAP IS VALID)
	## Start new lap time
	record_lap_time()
	current_lap += 1
	restart_stopwach()

func record_lap_time() -> void:
	lap_history.append(current_stopwatch)

func restart_stopwach() -> void:
	current_stopwatch = 0

func seconds_to_string_time(time: float) -> String:
	var time_string : String = str(time)
	time_string = str("%02d:%02d:%02d" % [time/60, int(time)%60, fmod(time*100,100)])
	return time_string

func get_current_time() -> String:
	return seconds_to_string_time(current_stopwatch)

func get_last_time() -> String:
	if current_lap <= 0:
		return str(0)
	return seconds_to_string_time(lap_history[current_lap-1])
