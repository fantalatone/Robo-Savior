extends Node

@onready var interior: Node = $Interior
@onready var exterior: Node = $Exterior

var current_scene: Node = null

func _ready() -> void:
	_switch_scene("Interior") 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("change_scale"): 
		_switch_scene("Exterior" if current_scene.name == "Interior" else "Interior")

func _switch_scene(scene_name: String) -> void:
	if current_scene:
		current_scene.visible = false
	current_scene = get_node(scene_name)
	current_scene.visible = true
