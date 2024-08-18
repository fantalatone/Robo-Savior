extends Node
class_name FragilesController

@export var DESTRUCTIBLES : Array[ FragileObject ]
@export var MANAGED : Array[ FragileObject ]

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		_got_hit()

func _got_hit():
	if randf() > 0.375:
		var f : FragileObject = DESTRUCTIBLES.pick_random()
		f.health = 5
		print("Hi!")
		f._update_visuals()
