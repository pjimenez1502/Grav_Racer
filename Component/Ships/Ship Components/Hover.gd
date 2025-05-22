extends Node
class_name ShipHover

@onready var hover_raycast: RayCast3D = $HoverRaycast

func _physics_process(delta: float) -> void:
	if hover_raycast.is_colliding():
		return
	
