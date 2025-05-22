extends Node
class_name ShipBurner

var ship_rb : RigidBody3D

@export var burner_power : int = 100
@export var heat_efficiency: int = 100
@export var heat_storage: int = 100

var heat_capacity: int
var heat_current: float

func burner(burn: float, heat_gen: float) -> Dictionary[String, float]:
	heat_update(heat_gen)
	
	if !heat_update(-heat_burn(burn)):
		return {"power": 0, "heat": heat_current}
	var power : float = thrust(burn)
	return {"power": power, "heat": heat_current}

func thrust(burn: float) -> float:
	var power : float = burner_power * 0.4 * burn
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	
	return power
	#print("#BURNERPOWER: ", -ship_rb.transform.basis.z * power)

func heat_setup() -> void:
	heat_capacity = 100 + heat_storage

func heat_update(heat_flow: float) -> bool:
	heat_current = clamp(heat_current + heat_flow, 0, heat_capacity)
	if heat_current == 0:
		return false
	return true

func heat_burn(burn: float) -> float:
	return burn * (100 + (100-heat_efficiency) * 2) / 100
