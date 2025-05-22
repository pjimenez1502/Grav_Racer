extends Node
class_name ShipChasis

var ship_rb : RigidBody3D

@export var drag_power : int = 100
@export var fuel : int = 100

var fuel_capacity : int
var fuel_current : float

func chasis(speed: float, fuel_burn: float) -> Dictionary[String, float]:
	var drag : float = chasis_drag(speed)
	var fuel_current : float = fuel_burn(fuel_burn)

	return {"drag": drag, "fuel": fuel_current}

func chasis_drag(forward_speed: float) -> float:
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var forward_drag : float = (drag_power) * (forward_speed**2 / 2) / 1000000
	ship_rb.apply_force(ship_rb.transform.basis.z * -forward_drag)
	
	return forward_drag
	#print("#CHASISDRAG: ", forward_drag)

func fuel_setup() -> void:
	fuel_capacity = fuel * 100
	fuel_current = fuel_capacity

func refuel() -> void:
	fuel_current = fuel_capacity

func fuel_burn(fuel_burn: float) -> float:
	fuel_current -= fuel_burn
	return fuel_current
