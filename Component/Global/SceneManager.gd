extends Node

var GAME_SCENE : Control
const SCENE_DICTIONARY : Dictionary[String, PackedScene] = {
	"startmenu": preload("res://Component/UI/StartMenu.tscn"),
	"quicksesh": preload("res://Component/UI/CircuitSelection/CircuitSelectScreen.tscn"),
	#"settings": preload()
	}

enum DIRECTION {LEFT, RIGHT, UP, DOWN}

func set_game_scene(scene: Control) -> void:
	GAME_SCENE = scene

func ui_transition(current_scene: Control, scene_id: String, direction: DIRECTION) -> void:
	var position : Vector2 = get_transition_position(direction)
	var transition_speed : float = 0.2
	
	var new_scene : Control = SCENE_DICTIONARY[scene_id].instantiate()
	GAME_SCENE.add_child(new_scene)
	new_scene.position = -position
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(current_scene, "position", position, transition_speed)
	tween.parallel().tween_property(new_scene, "position", Vector2(0,0), transition_speed)
	
	await tween.finished
	current_scene.queue_free()

func get_transition_position(direction: DIRECTION) -> Vector2:
	var distance : int = 2000
	match direction:
		DIRECTION.LEFT:
			return Vector2(1,0) * distance
		DIRECTION.RIGHT:
			return Vector2(-1,0) * distance
	
	return Vector2(-1,0) * distance

func scene_transition(current_scene: Control, scene_id:String) -> void:
	var new_scene : Control = SCENE_DICTIONARY[scene_id].instantiate()
	GAME_SCENE.add_child(new_scene)
	
	current_scene.queue_free()

func pause_game(value: bool) -> void:
	get_tree().paused = value
