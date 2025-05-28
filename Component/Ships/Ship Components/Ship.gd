extends RigidBody3D
class_name Ship

@onready var telemetry: ShipTelemetry = $TELEMETRY
@onready var components: ShipComponents = $SHIP_COMPONENTS
@onready var ship_mesh: Node3D = $"Ship Mesh"
@onready var player_input: ShipPlayerControl = $PLAYER_INPUT


func _ready() -> void:
	components.ship = self
	components.init_ship()
