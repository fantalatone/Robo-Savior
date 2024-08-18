extends Node
class_name HealthSystem

@export var MAX_HEALTH : int = 10000

var current_health : int

signal damage_taken

func _ready() -> void:
	current_health = MAX_HEALTH

func _damage( amount: int ) -> void:
	current_health -= amount
	print("Took some damages!")
	damage_taken.emit()
	if current_health <= 0:
		print("Dead! :P")
