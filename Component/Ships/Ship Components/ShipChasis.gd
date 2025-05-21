extends Node
class_name ShipChasis

var ship_rb : RigidBody3D

@export var drag_power : float

func chasis_drag(forward_speed: float) -> void:
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var forward_drag : float = (drag_power) * (forward_speed**2 / 2) / 500000
	ship_rb.apply_force(ship_rb.transform.basis.z * -forward_drag)
	
	#print("#CHASISDRAG: ", forward_drag)
