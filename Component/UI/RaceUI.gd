extends Control
class_name RaceUI

@export var player_ship: ShipComponents

@onready var speed_value: Label = %"Speed Value"
@onready var fuel_value: Label = %"Fuel Value"
@onready var heat_value: Label = %"Heat Value"

@onready var current_time: Label = %CurrentTime
@onready var last_lap_time: Label = %LastLapTime

func _physics_process(delta: float) -> void:
	speed_value.text = str(int(player_ship.telemetry.telemetry_speedometer() * 3.6))
	fuel_value.text = str(int(player_ship.telemetry.telemetry_fuel()))
	heat_value.text = str(int(player_ship.telemetry.telemetry_heat()))
	
	
	current_time.text = player_ship.telemetry.stopwatch.get_current_time()
	last_lap_time.text = player_ship.telemetry.stopwatch.get_last_time()
