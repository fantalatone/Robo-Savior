extends CharacterBody3D
class_name Enemy

@export var MAX_HEALTH : int = 100
var health : int = 100

func _damage( amount: int ):
	health -= amount
	if health <= 0:
		ScoreController.score_up(1)
		queue_free()
