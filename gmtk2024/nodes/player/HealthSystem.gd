extends Node
class_name HealthSystem

@export var MAX_HEALTH : int = 10000

var current_health : int

func _ready() -> void:
	current_health = MAX_HEALTH

func _damage( amount: int ) -> void:
	current_health -= amount
	print("Took some damages!")
	if current_health <= 0:
		print("Ded!")
