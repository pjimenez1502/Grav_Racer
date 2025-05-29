extends Control
class_name RacePauseMenu

@onready var restart_button: Button = %Restart
@onready var resume_button: Button = %Resume
@onready var exit_button: Button = %Exit

var open : bool

func _ready() -> void:
	visible = open

func toggle() -> void:
	set_open(!open)

func set_open(value: bool) -> void:
	open = value
	visible = value
	SceneManager.pause_game(value)
	if value:
		set_focus()

func restart() -> void:
	RaceDirector.replace_ship()
	set_open(false)

func resume() -> void:
	set_open(false)

func exit() -> void:
	SceneManager.scene_transition(get_parent().get_parent(), "quicksesh")
	SceneManager.pause_game(false)



func set_focus() -> void:
	restart_button.grab_focus()
