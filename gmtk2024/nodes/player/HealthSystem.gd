extends Node
class_name HealthSystem

signal damage_taken

@export var DAMAGE_TO_EXPLODE : int = 4
var CURRENT_TOTAL_DAMAGE : int = 0

var death_timer : Timer = Timer.new()

func _ready() -> void:
	death_timer.one_shot = true
	death_timer.timeout.connect(_death)
	add_child(death_timer)
	
	damage_taken.connect(get_tree().current_scene.find_child("Fragiles Controller")._got_hit)


func _damage() -> void:
	damage_taken.emit()

func _add_damage_point( amount: int ) -> void:
	CURRENT_TOTAL_DAMAGE += amount
	
	if CURRENT_TOTAL_DAMAGE == DAMAGE_TO_EXPLODE:
		death_timer.start(20)
	
	GUIController.instance.HEALTH_LABEL.text = str(CURRENT_TOTAL_DAMAGE)

func _death() -> void:
	print("Ded!")
	get_tree().quit()

func _remove_damage_point() -> void:
	CURRENT_TOTAL_DAMAGE -= 1
	death_timer.stop()
	GUIController.instance.HEALTH_LABEL.text = str(CURRENT_TOTAL_DAMAGE)
