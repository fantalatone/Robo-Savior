extends Node
class_name InteriorController

@export var fragile_object : FragileObject

func _ready() -> void:
	fragile_object.health = 5
	fragile_object._update_visuals()
