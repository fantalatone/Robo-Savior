extends Interaction
class_name ItemInteraction

@export var item_type : ITEM_TYPE
var item_taken : bool = false

@onready var GHOST = preload("res://nodes/maps/ghost-item.tres")

func _take_item() -> bool:
	if item_taken: return false
	var m : MeshInstance3D = get_child(1).get_child(0)
	m.material_override = GHOST
	item_taken = true
	return true

func _drop_item() -> bool:
	if not item_taken: return false
	var m : MeshInstance3D = get_child(1).get_child(0)
	m.material_override = null
	item_taken = false
	return true
