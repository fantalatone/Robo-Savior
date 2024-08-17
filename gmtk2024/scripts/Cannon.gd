extends StaticBody3D
class_name Cannon

const MOUSE_SENSIVITY = 0.0001

@onready var BARREL_PIVOT = $"Barrel Pivot"
@onready var BARREL_POINT = $"Barrel Pivot/Barrel Point"

@onready var CANNON_BULLET = preload("res://scenes/plasma_bullet.tscn")

const MAX_FUEL_AMOUNT : int = 3
var fuel_level : int = 0

var is_being_controlled : bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_being_controlled:
		rotate_barrel(event.relative)
	if event is InputEventMouseButton and is_being_controlled and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if fuel_level == MAX_FUEL_AMOUNT:
			shoot_cannon_bullet()
			fuel_level = 0

func rotate_barrel( relative : Vector2 ) -> void:
	BARREL_PIVOT.rotate_y(relative.x * MOUSE_SENSIVITY * -1)
	BARREL_PIVOT.rotate_x(relative.y * MOUSE_SENSIVITY * -1)

func shoot_cannon_bullet() -> void:
	var b = CANNON_BULLET.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = BARREL_POINT.global_position
	b.rotation = BARREL_POINT.global_rotation

func _disable_input() -> void:
	is_being_controlled = false

func _enable_input() -> void:
	is_being_controlled = true

func _on_input(body: Node3D) -> void:
	if body.is_in_group("Fuels") and fuel_level < MAX_FUEL_AMOUNT:
		body.queue_free()
		fuel_level += 1
