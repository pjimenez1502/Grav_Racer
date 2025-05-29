extends Control

@onready var chromatic_aberration_filter: ColorRect = $"Chromatic Aberration Filter"

func _ready() -> void:
	SceneManager.set_game_scene(self)
