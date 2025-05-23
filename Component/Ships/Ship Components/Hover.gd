extends Node
class_name ShipHover

var ship_rb : RigidBody3D

@export var hover_raycast: RayCast3D
var hover_strength : float = 1
var current_hover_influence : float

func _ready() -> void:
	add_child(debugray)
	
func _physics_process(delta: float) -> void:
	#physics_hover(delta)
	hard_hover(delta)

func physics_hover(delta: float) -> void:
	var over_ground : bool = hover_raycast.is_colliding()
	var hover_direction : float = 1 if over_ground else -1
	
	current_hover_influence = lerp(current_hover_influence, hover_direction, delta * 100)
	#print("HOVER INFL: ", current_hover_influence, " overground: ", over_ground)
	ship_rb.apply_force(ship_rb.transform.basis.y * current_hover_influence * 200)

@export var track_raycast: RayCast3D
var hover_distance : float = 4
var current_height : float

@onready var ship_up: Node3D = $"../../Ship UP"
@onready var ship: Node3D = $"../../Ship UP/SHIP"
var debugray := RayCast3D.new()

func hard_hover(delta: float) -> void:
	## Detect track below car (col 4) -> raycast down to get track collider. Get normal of face hit. Rotate ship according to normal.
	## If stops detecting track below can get lost??
	if !track_raycast.is_colliding():
		print("NO TRACK")
		return
	
	var track_normal : Vector3 = track_raycast.get_collision_normal()
	var track_distance : Vector3 = (track_raycast.global_position - track_raycast.get_collision_point())
	var distance_offset : float = (track_distance.length() - hover_distance) * -1
	
	#print("TRACK_NORMAL: ", track_normal, " // TRACK_DISTANCE: ", distance_offset, " // shipY: ", ship_rb.position.y)
	#print("TRACK_POINT: ", track_raycast.get_collision_point(), " // TRACK_POINT: ", track_raycast.get_collision_point() + (Vector3.UP * 100))
	ship_rb.position.y = lerp(ship_rb.position.y, ship_rb.position.y + distance_offset, delta * 100)
	
	#ship.global_transform = align_with_normal(ship.global_transform, track_normal)
	#ship.global_transform = ship.global_transform.interpolate_with(align_with_normal(ship.global_transform, track_normal), 0.2)
		

func align_with_normal(_transform: Transform3D, normal: Vector3) -> Transform3D:
	_transform.basis.y = normal
	_transform.basis.x = _transform.basis.z.cross(normal)
	_transform.basis = _transform.basis.orthonormalized()
	return _transform
