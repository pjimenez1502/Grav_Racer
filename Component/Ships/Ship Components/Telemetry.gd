extends Node
class_name ShipTelemetry

@export var ship_rb : RigidBody3D
@export var telemetry_print : bool

var fuel: int

func _physics_process(delta: float) -> void:
	if !telemetry_print:
		return
	#print("SPEED: ", telemetry_speedometer(), " Mps")
	#print("SIDESLIP: ", telemetry_sideslip(), " Mps")
	#print("SPEED: ", telemetry_speedometer() * 3.6, " Kmh")
	#print("SIDESLIP: ", telemetry_sideslip() * 3.6, " Kmh")
	pass

func telemetry_speedometer() -> float:
	return -ship_rb.transform.basis.z.dot(ship_rb.linear_velocity.normalized()) * ship_rb.linear_velocity.length()

func telemetry_sideslip() -> float:
	return ship_rb.transform.basis.x.dot(ship_rb.linear_velocity.normalized()) * ship_rb.linear_velocity.length()

func update_fuel(_fuel: int) -> void:
	fuel = _fuel

func telemetry_fuel() -> int:
	return fuel
