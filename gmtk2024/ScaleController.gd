extends Node
class_name ScaleController

enum SCALE { HUMAN, ROBOT, CANNON }

var human : Player
var robot : Robot
var cannon : Cannon

var current_scale : SCALE = SCALE.ROBOT

func _ready() -> void:
	human = get_tree().current_scene.find_child("Player")
	robot = get_tree().current_scene.find_child("Robot")
	cannon = get_tree().current_scene.find_child("Cannon")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("prototype_tab"):
		_change_scale(2)

func _change_scale( scale : int ) -> void:
	current_scale = scale
	
	match scale:
		SCALE.HUMAN:
			#human._enable_input()
			robot._disable_input()
			cannon._disable_input()
		SCALE.ROBOT:
			#human._disable_input()
			robot._enable_input()
			cannon._disable_input()
		SCALE.CANNON:
			#human._disable_input()
			robot._disable_input()
			cannon._enable_input()
