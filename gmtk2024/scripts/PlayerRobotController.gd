extends Node

enum USER { PLAYER, ROBOT }
@export var current_user : USER = USER.PLAYER

var player : Player
var robot : Robot

func _ready() -> void:
	player = get_tree().current_scene.find_child("Player")
	robot = get_tree().current_scene.find_child("Robot")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("prototype_tab"):
		switch_player_robot()

func switch_player_robot() -> void:
	if current_user == USER.PLAYER:
		current_user = USER.ROBOT
		robot.process_mode = Node.PROCESS_MODE_INHERIT
		robot.CAM.current = true
		player.process_mode = Node.PROCESS_MODE_DISABLED
		player.CAM.current = false
		return
	
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.CAM.current = true
	robot.process_mode = Node.PROCESS_MODE_DISABLED
	robot.CAM.current = false
	current_user = USER.PLAYER
	
