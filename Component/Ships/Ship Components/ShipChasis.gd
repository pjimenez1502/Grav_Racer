extends Node
class_name ShipChasis

var ship_rb : RigidBody3D

@export var drag_power : int = 100
@export var fuel_capacity : int = 100

var tank_capacity : int
var current_fuel : int

func chasis(speed: float, fuel_burn: float) -> Dictionary[String, float]:
	var drag : float = chasis_drag(speed)
	var current_fuel : int = fuel_burn(fuel_burn)

	return {"drag": drag, "fuel": current_fuel}

func chasis_drag(forward_speed: float) -> float:
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var forward_drag : float = (drag_power) * (forward_speed**2 / 2) / 1000000
	ship_rb.apply_force(ship_rb.transform.basis.z * -forward_drag)
	
	return forward_drag
	#print("#CHASISDRAG: ", forward_drag)

func fuel_setup() -> void:
	tank_capacity = fuel_capacity * 100
	current_fuel = tank_capacity

func refuel() -> void:
	current_fuel = tank_capacity

func fuel_burn(fuel_burn: float) -> int:
	current_fuel -= fuel_burn
	return current_fuel
