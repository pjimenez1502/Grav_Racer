extends Control
class_name StartMenu

@onready var buttons: VBoxContainer = $Control/Buttons

func _ready() -> void:
	focus_first_button()

func focus_first_button() -> void:
	buttons.get_child(0).grab_focus()


func open_quick_session() -> void:
	SceneManager.ui_transition(self, "quicksesh", SceneManager.DIRECTION.RIGHT)
	pass

func open_settings() -> void:
	pass

func exit() -> void:
	get_tree().quit()
