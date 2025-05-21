extends Node
class_name ShipComponents

@onready var telemetry: ShipTelemetry = $"../TELEMETRY"

@export var ship_rb: RigidBody3D
@export var ship_mesh: Node3D

@onready var player_input: ShipPlayerControl = $"../PLAYER_INPUT"

@onready var engine: ShipEngine = $ENGINE	# Power
@onready var burner: ShipBurner = $BURNER			# Boost
@onready var chasis: ShipChasis = $CHASIS			# Drag
@onready var bodywork: ShipBodywork = $BODYWORK		# Lateral Drifting
@onready var brakes: ShipBrakes = $BRAKES			# Braking

func _ready() -> void:
	init_ship()

func _physics_process(delta: float) -> void:
	ship_running()

func init_ship() -> void:
	engine.ship_rb = ship_rb
	burner.ship_rb = ship_rb
	chasis.ship_rb = ship_rb
	brakes.ship_rb = ship_rb
	bodywork.ship_rb = ship_rb

func ship_running() -> void:
	engine.thrust(player_input.get_throttle())
	
	burner.thrust(player_input.get_burner())
	
	chasis.chasis_drag(telemetry.telemetry_speedometer())
	bodywork.bodywork_drag(telemetry.telemetry_sideslip())
	bodywork.turning(player_input.get_turn_axis(), telemetry.telemetry_speedometer(), ship_mesh)
	
	brakes.braking(player_input.get_brake(), telemetry.telemetry_speedometer())
