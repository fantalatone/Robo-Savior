extends CharacterBody3D
class_name Enemy

@export var MAX_HEALTH : int = 100
var health : int = 100

@export var MESH : MeshInstance3D

@onready var flash_mat = preload("res://materials/flash.tres")

var t : Timer = Timer.new()

func _ready() -> void:
	t.one_shot = true
	t.timeout.connect(func(): 	MESH.material_overlay = null)
	add_child(t)

func _damage( amount: int ):
	health -= amount
	MESH.material_overlay = flash_mat
	t.start(0.05)
	if health <= 0:
		ScoreController.score_up(50)
		queue_free()
