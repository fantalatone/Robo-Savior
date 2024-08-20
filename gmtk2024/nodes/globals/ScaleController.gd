extends Node
class_name ScaleController

enum SCALE { HUMAN, ROBOT }

var human : Player
var robot : Robot

var current_scale : SCALE = SCALE.HUMAN

func init_system() -> void:
	human = get_tree().current_scene.find_child("Player")
	robot = get_tree().current_scene.find_child("Robot")

func _change_to_robot():
	current_scale = SCALE.ROBOT
	_change_scale()

func _change_to_human():
	current_scale = SCALE.HUMAN
	_change_scale()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if Input.is_action_just_pressed("escape"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _change_scale() -> void:
	
	var g = get_tree().current_scene.find_child("Game Music")
	g.set_parameter("Scale Change", current_scale)
	print()
	
	if human and robot:
		match current_scale:
			SCALE.HUMAN:
				human._enable_input()
				human._enable_audio()
				robot._disable_input()
				robot._disable_audio()
			SCALE.ROBOT:
				human._disable_input()
				human._disable_audio()
				robot._enable_input()
				robot._enable_audio()
