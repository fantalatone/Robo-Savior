extends Node
class_name HealthSystem

signal damage_taken

var CURRENT_TOTAL_DAMAGE : int = 0

func _damage( amount: int ) -> void:
	damage_taken.emit()

func _add_damage_point( amount: int ) -> void:
	CURRENT_TOTAL_DAMAGE += amount
	
	GUIController.instance.HEALTH_LABEL.text = str(CURRENT_TOTAL_DAMAGE)
	print(CURRENT_TOTAL_DAMAGE)

func _remove_damage_point() -> void:
	CURRENT_TOTAL_DAMAGE -= 1
	GUIController.instance.HEALTH_LABEL.text = str(CURRENT_TOTAL_DAMAGE)
	print(CURRENT_TOTAL_DAMAGE)
