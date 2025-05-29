extends TextureButton
class_name CircuitButton

@onready var circuit_icon: TextureRect = %"Circuit Icon"
@onready var circuit_name: Label = %"Circuit Name"
var circuit_data: CircuitData

signal CIRCUIT_SELECTED

func populate_button(circuit_data: CircuitData) -> void:
	circuit_icon.texture = circuit_data.icon
	circuit_name.text = circuit_data.name
	self.circuit_data = circuit_data
 
func pressed() -> void:
	CIRCUIT_SELECTED.emit(circuit_data.id)




func _on_mouse_entered() -> void:
	scale = Vector2.ONE * 1.2
func _on_mouse_exited() -> void:
	scale = Vector2.ONE
