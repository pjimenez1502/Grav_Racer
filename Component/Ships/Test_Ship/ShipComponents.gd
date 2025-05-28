extends Node
class_name ShipComponents

var ship: Ship
@onready var engine: ShipEngine = $ENGINE			# Power
@onready var chasis: ShipChasis = $CHASIS			# Drag
@onready var bodywork: ShipBodywork = $BODYWORK		# Lateral Drifting
@onready var brakes: ShipBrakes = $BRAKES			# Braking
@onready var burner: ShipBurner = $BURNER			# Boost
@onready var hover: ShipHover = $HOVER


func _physics_process(delta: float) -> void:
	ship_running()

func init_ship() -> void:
	engine.ship_rb = ship
	chasis.ship_rb = ship
	brakes.ship_rb = ship
	bodywork.ship_rb = ship
	burner.ship_rb = ship
	
	hover.ship_rb = ship
	hover.ship_mesh = ship.ship_mesh
	
	chasis.fuel_setup()
	burner.heat_setup()
	hover.hover_rotation_setup()

func ship_running() -> void:
	var engine_telemetry : Dictionary = engine.thrust(ship.player_input.get_throttle())
	var brakes_telemetry : Dictionary = brakes.braking(ship.player_input.get_brake(), ship.telemetry.telemetry_speedometer())
	var chasis_telemetry : Dictionary = chasis.chasis(ship.telemetry.telemetry_speedometer(), engine_telemetry["fuel_flow"])
	var bodywork_telemetry : Dictionary = bodywork.bodywork(ship.telemetry.telemetry_sideslip(), ship.player_input.get_turn_axis(), ship.telemetry.telemetry_speedometer(), ship.ship_mesh)
	var burner_telemetry : Dictionary = burner.burner(ship.player_input.get_burner(), brakes_telemetry["heat"])
	
	ship.telemetry.update_fuel(chasis_telemetry["fuel"])
	ship.telemetry.update_heat(burner_telemetry["heat"])
	ship.telemetry.update_stiffening(bodywork_telemetry["stiffening"])
