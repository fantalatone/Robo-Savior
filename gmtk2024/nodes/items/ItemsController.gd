extends Node3D
class_name ItemsController

var ITEMS = { }

func _ready() -> void:
	for c in get_children():
		ITEMS[c.type] = c

func show_tool( type: Interaction.ITEM_TYPE ):
	hide_tools()
	for c : Item in get_children():
		if c.type == type:
			c.visual.show()

func hide_tools():
	for c : Item in get_children():
		c.visual.hide()

func start_using_item( type: Interaction.ITEM_TYPE ):
	ITEMS[type].start_use()

func stop_using_item( type: Interaction.ITEM_TYPE ):
	ITEMS[type].stop_use()
