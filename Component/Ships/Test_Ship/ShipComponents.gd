extends Node
class_name ShipComponents

@onready var telemetry: ShipTelemetry = $"../TELEMETRY"

@export var ship_rb: RigidBody3D
@export var ship_mesh: Node3D

@onready var player_input: ShipPlayerControl = $"../PLAYER_INPUT"

@onready var engine: ShipEngine = $ENGINE			# Power
@onready var chasis: ShipChasis = $CHASIS			# Drag
@onready var bodywork: ShipBodywork = $BODYWORK		# Lateral Drifting
@onready var brakes: ShipBrakes = $BRAKES			# Braking
@onready var burner: ShipBurner = $BURNER			# Boost

func _ready() -> void:
	init_ship()

func _physics_process(delta: float) -> void:
	ship_running()

func init_ship() -> void:
	engine.ship_rb = ship_rb
	chasis.ship_rb = ship_rb
	brakes.ship_rb = ship_rb
	bodywork.ship_rb = ship_rb
	burner.ship_rb = ship_rb
	
	chasis.fuel_setup()
	burner.heat_setup()

func ship_running() -> void:
	var engine_telemetry : Dictionary = engine.thrust(player_input.get_throttle())
	var brakes_telemetry : Dictionary = brakes.braking(player_input.get_brake(), telemetry.telemetry_speedometer())
	var chasis_telemetry : Dictionary = chasis.chasis(telemetry.telemetry_speedometer(), engine_telemetry["fuel_flow"])
	var bodywork_telemetry : Dictionary = bodywork.bodywork(telemetry.telemetry_sideslip(), player_input.get_turn_axis(), telemetry.telemetry_speedometer(), ship_mesh)
	var burner_telemetry : Dictionary = burner.burner(player_input.get_burner(), brakes_telemetry["heat"])
	
	telemetry.update_fuel(chasis_telemetry["fuel"])
	telemetry.update_heat(burner_telemetry["heat"])
	telemetry.update_stiffening(bodywork_telemetry["stiffening"])
