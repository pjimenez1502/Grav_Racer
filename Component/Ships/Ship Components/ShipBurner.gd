extends Node
class_name ShipBurner

var ship_rb : RigidBody3D

@export var burner_power : int = 100

func thrust(burn: float) -> Dictionary[String, float]:
	var power : float = burner_power * 0.4 * burn
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	
	return {"power": power}
	#print("#BURNERPOWER: ", -ship_rb.transform.basis.z * power)
