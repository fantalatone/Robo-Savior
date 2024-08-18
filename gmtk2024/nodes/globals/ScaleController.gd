extends Node
class_name ScaleController

enum SCALE { HUMAN, ROBOT }

var human : Player
var robot : Robot

var current_scale : SCALE = SCALE.HUMAN

func _ready() -> void:
	human = get_tree().current_scene.find_child("Player")
	robot = get_tree().current_scene.find_child("Robot")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("change_scale"):
		_change_scale()

func _change_scale() -> void:
	current_scale = SCALE.ROBOT if current_scale == SCALE.HUMAN else SCALE.HUMAN
	
	match current_scale:
		SCALE.HUMAN:
			human._enable_input()
			robot._disable_input()
		SCALE.ROBOT:
			human._disable_input()
			robot._enable_input()
