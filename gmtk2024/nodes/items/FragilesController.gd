extends Node
class_name FragilesController

@export var DESTRUCTIBLES : Array[ FragileObject ]
@export var MANAGED : Array[ FragileObject ]

func _ready() -> void:
	Robot.instance.HEALTH.damage_taken.connect(_got_hit)

func _got_hit():
	if randf() < 0.375:
		var f : FragileObject = DESTRUCTIBLES.pick_random()
		if f.damage == 2:
			return
		f._broke_one_level()
