extends Node
class_name ShipBodywork

var ship_rb : RigidBody3D

@export var sideslip_drag_power : float = 100
@export var turning_power : float = 100

func bodywork_drag(sideslip: float) -> void:
	#var sideslip : float = ship_rb.global_transform.basis.x.dot(ship_rb.linear_velocity)
	var sidedrag : float = (sideslip_drag_power) * (sideslip**2 / 2) / 150 * -sign(sideslip)
	ship_rb.apply_force(ship_rb.transform.basis.x * sidedrag)
	ship_rb.apply_force(-ship_rb.transform.basis.z * abs(sidedrag / 8))
	
	#print("#BODYWORKDRAG: ", sidedrag)

func turning(turn_axis: float, forward_speed: float, ship_mesh: Node3D) -> void:
	var turn_power : float = turning_power * 10 * turn_axis
	
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var speed_turn_deficit : float = 1 - forward_speed / 200
	ship_rb.apply_torque(-ship_rb.transform.basis.y * turn_power * speed_turn_deficit)
	#print(-ship_rb.transform.basis.y * turn_power * speed_turn_deficit)
	#print(speed_turn_deficit)
	
	turning_bank(turn_axis, speed_turn_deficit, ship_mesh)

func turning_bank(turn_axis: float, speed_turn_deficit: float, ship_mesh: Node3D) -> void:
	ship_mesh.rotation.z = lerp_angle(ship_mesh.rotation.z, -deg_to_rad(40 * turn_axis * speed_turn_deficit), .05)
	pass
