extends Interaction
class_name ItemInteraction

@export var item_type : ITEM_TYPE
var item_taken : bool = false

func _take_item() -> bool:
	if item_taken: return false
	get_child(1).hide()
	item_taken = true
	return true

func _drop_item() -> bool:
	if not item_taken: return false
	get_child(1).show()
	item_taken = false
	return true
