extends Node

const TEST_SHIP = preload("res://Component/Ships/Test_Ship/test_ship.tscn")
const RACE_SCENE = preload("res://Component/UI/RaceScene.tscn")


var player_ship_components : ShipComponents
var ship_rb : RigidBody3D

var circuit : Circuit
var race_scene : RaceScene

func _ready() -> void:
	pass

func restart_lap() -> void:
	pass

func replace_ship() -> void:
	if ship_rb:
		ship_rb.queue_free()
	ship_rb = spawn_player_ship()
	
	circuit.place_ship_at_spawn(ship_rb)
	race_scene.race_ui.player_ship = ship_rb

func load_circuit(circuit_data: CircuitData) -> void:
	race_scene = RACE_SCENE.instantiate()
	get_tree().root.add_child(race_scene)
	
	circuit = circuit_data.scene.instantiate()
	race_scene.sub_viewport.add_child(circuit)
	
	replace_ship()

func spawn_player_ship() -> RigidBody3D:
	return TEST_SHIP.instantiate()
