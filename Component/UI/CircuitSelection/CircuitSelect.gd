extends Control

@export var circuit_list : Array[CircuitData]
@onready var button_container: HBoxContainer = $ButtonContainer

var circuit_dictionary : Dictionary[String, CircuitData]
const CIRCUIT_SELECT_BUTTON = preload("res://Component/UI/CircuitSelection/CircuitSelectButton.tscn")

func _ready() -> void:
	for circuit_data: CircuitData in circuit_list:
		circuit_dictionary[circuit_data.id] = circuit_data
		
		var new_button : CircuitButton = CIRCUIT_SELECT_BUTTON.instantiate()
		button_container.add_child(new_button)
		new_button.populate_button(circuit_data)
		new_button.CIRCUIT_SELECTED.connect(select_circuit)

func select_circuit(circuit_id : String) -> void:
	RaceDirector.load_circuit(circuit_dictionary[circuit_id])
	queue_free()
