extends Node
class_name ShipBodywork

var ship_rb : RigidBody3D

@export var sideslip_drag_power : float

func bodywork_drag() -> void:
	var sideslip : float = ship_rb.global_transform.basis.x.dot(ship_rb.linear_velocity)
	var sidedrag : float = (sideslip_drag_power) * (sideslip**2 / 2) / 150 * -sign(sideslip)
	ship_rb.apply_force(ship_rb.transform.basis.x * sidedrag)
	
	#print("#BODYWORKDRAG: ", sidedrag)
