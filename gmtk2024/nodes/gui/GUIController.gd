extends Control
class_name GUIController

@onready var SCORE_LABEL : Label = $"Score Label"
@onready var HEALTH_LABEL : Label = $"Health Label"

static var instance

func _ready() -> void:
	instance = self
