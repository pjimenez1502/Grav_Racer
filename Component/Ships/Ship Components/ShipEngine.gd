extends Node
class_name ShipEngine

var ship_rb : RigidBody3D

@export var engine_power : int = 100
@export var fuel_efficiency: int = 100

func thrust(throttle: float) -> Dictionary[String, float]:
	var power : float = engine_power * 3 * throttle
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	
	var fuel_flow: float = throttle * (100 + (100-fuel_efficiency) * 2) / 100
	return {"power": power, "fuel_flow": fuel_flow}
	
	#print("#ENGINEPOWER: ", power)
	#print("#FUELFLOW: ", fuel_flow)
