extends Interaction
class_name ItemInteraction

@export var item_type : ITEM_TYPE
@export var item_mesh : Mesh

var item_taken : bool = false

@onready var mesh_visual = $Visual

func _ready() -> void:
	mesh_visual.mesh = item_mesh

func _take_item() -> void:
	mesh_visual.hide()
	item_taken = true

func _drop_item() -> void:
	mesh_visual.show()
	item_taken = false
