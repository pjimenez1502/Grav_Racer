extends Node
class_name ShipBurner

var ship_rb : RigidBody3D

@export var burner_power : float

func thrust(burn: float) -> void:
	var power : float = burner_power * 0.2 * burn
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	
	#print("#BURNERPOWER: ", -ship_rb.transform.basis.z * power)
