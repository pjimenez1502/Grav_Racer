extends Node3D
class_name Circuit

@export var spawn_point : Node3D

func place_ship_at_spawn(ship: Node3D) -> void:
	add_child(ship)
	ship.transform = spawn_point.transform
