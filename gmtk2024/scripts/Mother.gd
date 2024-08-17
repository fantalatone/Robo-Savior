extends StaticBody3D
class_name Mother

@export var MAX_HEALTH : int = 3000

var currrent_health : int

func _ready() -> void:
	currrent_health = MAX_HEALTH
