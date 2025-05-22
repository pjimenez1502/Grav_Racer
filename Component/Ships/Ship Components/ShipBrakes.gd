extends Node
class_name ShipBrakes

var ship_rb : RigidBody3D

@export var brake_power : int = 100
@export var heat_recycling : int = 100

func braking(brake: float, forward_speed: float) -> Dictionary[String, float]:
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var power : float
	if forward_speed > 0:
		power = brake_power * 2 * brake
		ship_rb.apply_force(ship_rb.transform.basis.z * power)
	else:
		power = brake_power * 0.2 * brake
		ship_rb.apply_force(ship_rb.transform.basis.z * power)
	
	var heat_generation: float = clamp(brake * forward_speed * heat_recycling / 10000, 0, INF)
	
	return {"power": power, "heat": heat_generation}
	#print("#HEATGEN:", heat_generation)
	#print("#BRAKEPOWER: ", power)
