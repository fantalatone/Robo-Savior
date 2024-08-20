extends Node
class_name FragilesController

@export var DESTRUCTIBLES : Array[ FragileObject ]
@export var MANAGED : Array[ FragileObject ]

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("Fragiles"):
		if MANAGED.has(i):
			continue
		DESTRUCTIBLES.append(i)

func _got_hit():
	if randf() < 0.5:
		var f : FragileObject = DESTRUCTIBLES.pick_random()
		if f.damage == 2:
			return
		f._broke_one_level()
