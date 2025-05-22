extends Control
class_name RaceUI

@export var player_ship: ShipComponents

@onready var speed_value: Label = %"Speed Value"
@onready var fuel_value: Label = %"Fuel Value"

func _physics_process(delta: float) -> void:
	speed_value.text = str(int(player_ship.telemetry.telemetry_speedometer() * 3.6))
	fuel_value.text = str(int(player_ship.telemetry.telemetry_fuel()))
