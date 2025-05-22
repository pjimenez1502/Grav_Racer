extends Control
class_name RaceUI

@export var player_ship: ShipComponents


@onready var speed_value: Label = %SpeedValue

func _physics_process(delta: float) -> void:
	speed_value.text = str(int(player_ship.telemetry.telemetry_speedometer() * 3.6))
