extends Node
class_name ShipEngine

var ship_rb : RigidBody3D

@export var engine_power : int

func thrust(throttle: float) -> void:
	var power : float = engine_power * 10 * throttle
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	#print("EnginePower: ", -ship_rb.transform.basis.z * power)

func turning(turn_axis: float) -> void:
	var turn_power : float = 1000 * turn_axis
	ship_rb.apply_torque(-ship_rb.transform.basis.y * turn_power)
