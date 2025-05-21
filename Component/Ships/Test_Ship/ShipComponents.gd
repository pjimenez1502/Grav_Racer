extends Node
class_name ShipComponents

@export var ship_rb: RigidBody3D

@onready var player_input: ShipPlayerControl = $"../PLAYER_INPUT"

@onready var engine: ShipEngine = $ENGINE	# Power
@onready var burner: Node = $BURNER			# Boost
@onready var chasis: Node = $CHASIS			# Drag
@onready var bodywork: Node = $BODYWORK		# Lateral Drifting
@onready var brakes: Node = $BRAKES			# Braking

func _ready() -> void:
	init_ship()

func _physics_process(delta: float) -> void:
	ship_running()

func init_ship() -> void:
	engine.ship_rb = ship_rb

func ship_running() -> void:
	engine.thrust(player_input.get_throttle())
	engine.turning(player_input.get_turn_axis())
