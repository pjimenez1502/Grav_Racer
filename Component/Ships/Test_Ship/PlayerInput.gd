extends Node
class_name ShipPlayerControl

func _physics_process(delta: float) -> void:
	#print("TURN: ", get_turn_axis(), " // THROTTLE: ", get_throttle(), " // BRAKE: ", get_brake(), " // BURNER: ", get_burner())
	pass

func get_turn_axis() -> float:
	return Input.get_axis("TURN_LEFT", "TURN_RIGHT")

func get_throttle() -> float:
	return Input.get_action_strength("THROTTLE")

func get_brake() -> float:
	return Input.get_action_strength("BRAKE")

func get_burner() -> float:
	return Input.is_action_pressed("BURNER")
