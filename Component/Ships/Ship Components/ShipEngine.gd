extends Node
class_name ShipEngine

var ship_rb : RigidBody3D

@export var engine_power : float = 100

func thrust(throttle: float) -> void:
	var power : float = engine_power * 2 * throttle
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	
	#print("#ENGINEPOWER: ", -ship_rb.transform.basis.z * power)
