extends Control
class_name RacePauseMenu

@onready var restart_button: Button = %Restart
@onready var resume_button: Button = %Resume
@onready var exit_button: Button = %Exit

var open : bool

func _ready() -> void:
	visible = open

func toggle() -> void:
	open = !open
	visible = open
	
	get_tree().paused = open
	
	if open:
		set_focus()

func restart() -> void:
	print("RESTART")
	pass

func resume() -> void:
	toggle()
	pass

func exit() -> void:
	get_tree().quit()
	pass



func set_focus() -> void:
	restart_button.grab_focus()
