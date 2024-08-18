extends Node
class_name HealthSystem

@export var MAX_HEALTH : int = 10000

var current_health : int

signal damage_taken

func _ready() -> void:
	current_health = MAX_HEALTH

func _damage( amount: int ) -> void:
	current_health -= amount
	GUIController.instance.HEALTH_LABEL.text = str(current_health)
	damage_taken.emit()
	if current_health <= 0:
		get_tree().change_scene_to_file("res://nodes/death_screen.tscn")

func _heal( amount: int ) -> void:
	current_health += amount
	if current_health >= MAX_HEALTH: current_health = MAX_HEALTH
	GUIController.instance.HEALTH_LABEL.text = str(current_health)
