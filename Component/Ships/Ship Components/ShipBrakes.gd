extends Node
class_name ShipBrakes

var ship_rb : RigidBody3D

@export var brake_power : int = 100

func braking(brake: float, forward_speed: float) -> Dictionary[String, float]:
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var power : float
	if forward_speed > 0:
		power = brake_power * 2 * brake
		ship_rb.apply_force(ship_rb.transform.basis.z * power)
	else:
		power = brake_power * 0.2 * brake
		ship_rb.apply_force(ship_rb.transform.basis.z * power)
	
	return {"power": power}
	
	#print("#BRAKEPOWER: ", power)
