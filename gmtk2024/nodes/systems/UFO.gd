extends Node3D

@onready var SPIDER := preload("res://nodes/enemies/spider.tscn")
@onready var EYEBULL := preload("res://nodes/enemies/eyebull.tscn")

const SPAWN_RADIUS = 50
@export var SPAWN_COOLDOWN : float

var target_position : Vector3

var cooldown_timer : Timer = Timer.new()
var move_tween : Tween

func _ready() -> void:
	move_tween = get_tree().create_tween()
	move_tween.finished.connect(spawn_enemy)
	
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)
	
	start_spawning()

func start_spawning() -> void:
	var xy = generate_spawn_point()
	target_position = Vector3(xy.x, global_position.y, xy.y)
	
	var t = (target_position.distance_to(global_position) / 100.0) * 5 
	move_tween.tween_property(self, "global_position", target_position, t).set_ease(Tween.EASE_IN_OUT)
	move_tween.play()

func generate_spawn_point() -> Vector2:
	var a = randf() * 2.0 * PI
	return Vector2(cos(a), sin(a)) * sqrt(randf()) * SPAWN_RADIUS

func spawn_enemy() -> void:
	move_tween.stop()
	
	cooldown_timer.start(SPAWN_COOLDOWN)
	cooldown_timer.timeout.connect(func(): start_spawning())
	
	if randf() < 0.25:
		var ey = EYEBULL.instantiate()
		get_tree().current_scene.add_child(ey)
		ey.global_position = global_position
		return
	var e = SPIDER.instantiate()
	get_tree().current_scene.add_child(e)
	e.global_position = global_position
