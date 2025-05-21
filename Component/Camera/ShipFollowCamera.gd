extends Camera3D
class_name ShipFollowCamera

@export var target : Node3D
@export var smooth_speed : float

func _physics_process(delta: float) -> void:
	camera_lerp(delta)
	
func camera_lerp(delta: float) -> void:
	global_position = lerp(global_position, target.global_position, delta * smooth_speed)
	
	var target_quat: Quaternion = Quaternion(target.global_transform.basis)
	var current_quat: Quaternion = Quaternion(global_transform.basis)
	var smoothed_quat: Quaternion = target_quat.slerp(current_quat, delta * 1)
	
	global_transform.basis = Basis(smoothed_quat)
