extends Node
class_name ShipBodywork

var ship_rb : RigidBody3D

@export var sideslip_drag_power : int = 100
@export var turning_power : int = 100

func bodywork(sideslip: float, turn_axis: float, speed: float, ship_mesh: Node3D) -> Dictionary[String, float]:
	
	var sidedrag : float = bodywork_drag(sideslip)
	var stiffening : float = turning(turn_axis, speed, ship_mesh)
	
	#print("#BODYWORKDRAG: ", sidedrag)
	return {"sidedrag": sidedrag, "stiffening": stiffening}

func bodywork_drag(sideslip: float) -> float:
	#var sideslip : float = ship_rb.global_transform.basis.x.dot(ship_rb.linear_velocity)
	var sidedrag : float = (sideslip_drag_power) * (sideslip**2 / 2) / 250 * -sign(sideslip)
	ship_rb.apply_force(ship_rb.transform.basis.x * sidedrag)
	##FORWARD COMPENSATION
	ship_rb.apply_force(-ship_rb.transform.basis.z * abs(sidedrag / 4))
	
	return sidedrag

func turning(turn_axis: float, forward_speed: float, ship_mesh: Node3D) -> float:
	var turn_power : float = turning_power * 10 * turn_axis
	var direction_stiffening : float = clamp(1 - forward_speed / 300, 0.2, 1)
	ship_rb.apply_torque(-ship_rb.transform.basis.y * turn_power * direction_stiffening)
	turning_bank(turn_axis, direction_stiffening, ship_mesh)
	return direction_stiffening

func turning_bank(turn_axis: float, direction_stiffening: float, ship_mesh: Node3D) -> void:
	ship_mesh.rotation.z = lerp_angle(ship_mesh.rotation.z, -deg_to_rad(40 * turn_axis * direction_stiffening), .05)
	pass
