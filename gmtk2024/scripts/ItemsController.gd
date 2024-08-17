extends Node3D
class_name ItemsController

var ITEMS = { }

func _ready() -> void:
	for c : Item in get_children():
		ITEMS[c.type] = c

func show_tool( type: Interaction.ITEM_TYPE ):
	hide_tools()
	ITEMS[type].mesh.show()

func hide_tools():
	for c : Item in get_children():
		c.mesh.hide()

func start_using_item( type: Interaction.ITEM_TYPE ):
	ITEMS[type].use()

func stop_using_item( type: Interaction.ITEM_TYPE ):
	ITEMS[type].stop_use()
