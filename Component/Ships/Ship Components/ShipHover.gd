extends Node
class_name ShipHover

var ship_rb : RigidBody3D
var ship_mesh : Node3D

func _physics_process(delta: float) -> void:
	#physics_hover(delta)
	hover_height(delta)
	hover_rotation(delta)
	
#@export var hover_raycast: RayCast3D
#var hover_strength : float = 1
#var current_hover_influence : float
#func physics_hover(delta: float) -> void:
	#var over_ground : bool = hover_raycast.is_colliding()
	#var hover_direction : float = 1 if over_ground else -1
	#
	#current_hover_influence = lerp(current_hover_influence, hover_direction, delta * 100)
	##print("HOVER INFL: ", current_hover_influence, " overground: ", over_ground)
	#ship_rb.apply_force(ship_rb.transform.basis.y * current_hover_influence * 200)

@export var track_raycast: RayCast3D
var hover_distance : float = 6
var current_height : float
func hover_height(delta: float) -> void:
	## Detect track below car (col 4) -> raycast down to get track collider. Get normal of face hit. Rotate ship according to normal.
	## If stops detecting track below can get lost??
	if !track_raycast.is_colliding():
		print("NO TRACK")
		return
	
	var track_normal : Vector3 = track_raycast.get_collision_normal()
	var track_distance : Vector3 = (track_raycast.global_position - track_raycast.get_collision_point())
	var distance_offset : float = (track_distance.length() - hover_distance) * -1
	var hover_multiplier : float = clamp(abs(distance_offset)/10, 0.05, 1)
	
	ship_rb.position.y = lerp(ship_rb.position.y, ship_rb.position.y + distance_offset, delta * 100 * hover_multiplier)
	print(distance_offset, " -- ", hover_multiplier)

var raycast_lenght : int = 10
var raycast_Forw : RayCast3D = RayCast3D.new()
var raycast_Back : RayCast3D = RayCast3D.new()
var raycast_Left : RayCast3D = RayCast3D.new()
var raycast_Right : RayCast3D = RayCast3D.new()
func hover_rotation_setup() -> void:
	raycast_Forw.position = Vector3(0,0,-4)
	raycast_Back.position = Vector3(0,0,4)
	raycast_Left.position = Vector3(-3,0,0)
	raycast_Right.position = Vector3(3,0,0)
	
	raycast_Forw.target_position = Vector3.DOWN * raycast_lenght
	raycast_Back.target_position = Vector3.DOWN * raycast_lenght
	raycast_Left.target_position = Vector3.DOWN * raycast_lenght
	raycast_Right.target_position = Vector3.DOWN * raycast_lenght
	
	ship_rb.add_child.call_deferred(raycast_Forw)
	ship_rb.add_child.call_deferred(raycast_Back)
	ship_rb.add_child.call_deferred(raycast_Left)
	ship_rb.add_child.call_deferred(raycast_Right)

func hover_rotation(delta: float) -> void:
	if !raycast_Back.is_inside_tree():
		return
	
	var distance_F : float = (raycast_Forw.global_position - raycast_Forw.get_collision_point()).length()
	var distance_B : float = (raycast_Back.global_position - raycast_Back.get_collision_point()).length()
	var pitch_axis : Vector2 = Vector2(distance_F, distance_B)
	var pitch_diff : float = pitch_axis.x - pitch_axis.y
	
	ship_mesh.rotation.x = lerp_angle(ship_mesh.rotation.x, -deg_to_rad(8 * pitch_diff/2), .05)
	
	var distance_R : float = (raycast_Right.global_position - raycast_Right.get_collision_point()).length()
	var distance_L : float = (raycast_Left.global_position - raycast_Left.get_collision_point()).length()
	var roll_axis : Vector2 = Vector2(distance_R, distance_L)
	var roll_diff : float = roll_axis.x - roll_axis.y
	
	ship_mesh.rotation.z = lerp_angle(ship_mesh.rotation.z, -deg_to_rad(8 * roll_diff), .05)

#func align_with_normal(_transform: Transform3D, normal: Vector3) -> Transform3D:
	#_transform.basis.y = normal
	#_transform.basis.x = _transform.basis.z.cross(normal)
	#_transform.basis = _transform.basis.orthonormalized()
	#return _transform
