extends Node
class_name CameraShake

@export var telemetry: ShipTelemetry
@export var camera: Camera3D
@export var shake_strength : float = .1

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var shake : float

func _process(delta: float) -> void:
	var intensity : float = 1-telemetry.direction_stiffening ** 2
	camera_shake(intensity)

func camera_shake(intensity: float) -> void:
	print(intensity)
	shake = shake_strength * intensity
	camera.h_offset = random_offset().x
	camera.v_offset = random_offset().y

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake, shake), rng.randf_range(-shake, shake))
