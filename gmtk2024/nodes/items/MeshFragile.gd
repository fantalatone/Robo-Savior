extends FragileObject

@export_group("Mesh Settings")
@export var high_damage_node : Node3D
@export var medium_damage_node : Node3D
@export var low_damage_node : Node3D

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
