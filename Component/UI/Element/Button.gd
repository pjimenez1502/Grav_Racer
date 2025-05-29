extends Button

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func show_focused(value: bool) -> void:
	if !value:
		scale = Vector2.ONE
		return
	if disabled:
		return
		
	scale = Vector2.ONE * 1.2

func _on_mouse_entered() -> void:
	show_focused(true)
func _on_mouse_exited() -> void:
	show_focused(false)

func _on_focus_entered() -> void:
	show_focused(true)
func _on_focus_exited() -> void:
	show_focused(false)
