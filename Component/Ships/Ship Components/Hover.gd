extends Node
class_name ShipHover

var ship_rb : RigidBody3D

@export var hover_raycast: RayCast3D
var hover_strength : float = 1
var current_hover_influence : float

func _physics_process(delta: float) -> void:
	var over_ground : bool = hover_raycast.is_colliding()
	var hover_direction : float = 1 if over_ground else -1
	
	current_hover_influence = lerp(current_hover_influence, hover_direction, delta * 100)
	#print("HOVER INFL: ", current_hover_influence, " overground: ", over_ground)
	ship_rb.apply_force(ship_rb.transform.basis.y * current_hover_influence * 200)
