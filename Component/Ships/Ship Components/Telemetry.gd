extends Node
class_name ShipTelemetry

@export var ship_rb : RigidBody3D
@export var telemetry_print : bool

func _physics_process(delta: float) -> void:
	if !telemetry_print:
		return
	print("SPEED: ", telemetry_speedometer())
	print("SIDESLIP: ", telemetry_sideslip())
	pass

func telemetry_speedometer() -> float:
	return -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity) * 3.6

func telemetry_sideslip() -> float:
	return ship_rb.global_transform.basis.x.dot(ship_rb.linear_velocity)

func telemetry_fuel() -> float:
	return 0
