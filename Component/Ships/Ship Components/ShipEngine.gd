extends Node
class_name ShipEngine

var ship_rb : RigidBody3D

@export var engine_power : float
@export var turning_power : float

func thrust(throttle: float) -> void:
	var power : float = engine_power * 1 * throttle
	ship_rb.apply_force(-ship_rb.transform.basis.z * power)
	
	#print("#ENGINEPOWER: ", -ship_rb.transform.basis.z * power)

func turning(turn_axis: float, forward_speed: float) -> void:
	var turn_power : float = turning_power * 100 * turn_axis
	
	#var forward_speed : float = -ship_rb.global_transform.basis.z.dot(ship_rb.linear_velocity)
	var speed_turn_deficit : float = 1 - forward_speed / 100
	ship_rb.apply_torque(-ship_rb.transform.basis.y * turn_power * speed_turn_deficit)
	print(speed_turn_deficit)
