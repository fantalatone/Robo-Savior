extends FragileObject

@export_group("Mesh Settings")
@export var high_damage_node : Node3D
@export var medium_damage_node : Node3D
@export var low_damage_node : Node3D

var Sound

func _ready() -> void:
	Sound = get_child(get_child_count() - 1)

func _broke_one_level():
	super._broke_one_level()
	
	if Sound and Sound is FmodEventEmitter3D:
		Sound.play()

func _fix_one_level():
	super._fix_one_level()
	
	if damage == 0:
		if Sound and Sound is FmodEventEmitter3D:
			Sound.stop()

func _update_visuals():
	high_damage_node.hide()
	medium_damage_node.hide()
	low_damage_node.hide()
	
	if damage == 0:
		low_damage_node.show()
	if damage == 1:
		medium_damage_node.show()
	if damage == 2:
		high_damage_node.show()
