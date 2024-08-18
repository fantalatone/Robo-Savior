extends Node3D
class_name WeaponsController

@onready var RAY : RayCast3D = %Ray
@onready var PICKUP_POINT : Marker3D = %"Pickup Point"
@onready var CAM : Camera3D = %Camera

@export_group("Plasma Gun")
@export var MAX_PLASMA_GUN_AMMO : int = 30
@export var PLASMA_GUN_RELOAD_TIME : float = 2.0
@export var PLASMA_GUN_FIRE_RATE : float = 0.2
@export var PLASMA_GUN_BARREL_POINT : Marker3D

@onready var PLASMA_BULLET := preload("res://nodes/player/bullet/bullet.tscn")

var is_firing : bool = false
var is_reloading : bool = false
var is_holding : bool = false

var current_plasma_ammo : int

var holding_throwable : RigidBody3D

var plasma_gun_timer : Timer = Timer.new()
var plasma_gun_reload_timer : Timer = Timer.new()

func _ready() -> void:
	current_plasma_ammo = MAX_PLASMA_GUN_AMMO
	
	plasma_gun_timer.one_shot = true
	add_child(plasma_gun_timer)
	
	plasma_gun_reload_timer.one_shot = true
	plasma_gun_reload_timer.timeout.connect(reload_ammo)
	add_child(plasma_gun_reload_timer)

func handle_actions( event : InputEventMouseButton ) -> void:
	if event.button_index == MOUSE_BUTTON_RIGHT:
		handle_throwables( event.is_pressed() )
		return
	
	if event.button_index != MOUSE_BUTTON_LEFT: return
	is_firing = event.is_pressed()

func handle_throwables( pressed : bool ) -> void:
	if not pressed:
		if is_holding:
			throw_throwable()
		return
	if RAY.is_colliding():
		if RAY.get_collider().is_in_group("Throwables"):
			pickup_throwable( RAY.get_collider() )

func handle_reload() -> void:
	is_reloading = true
	plasma_gun_reload_timer.start(PLASMA_GUN_RELOAD_TIME)

func _process(_delta: float) -> void:
	if is_reloading:
		return
	if not is_firing:
		return
	if not plasma_gun_timer.is_stopped():
		return
	if current_plasma_ammo <= 0:
		return
	
	print("Plasma Blast!")
	current_plasma_ammo -= 1
	plasma_gun_timer.start(PLASMA_GUN_FIRE_RATE)
	spawn_plasma_bullet()

func pickup_throwable( throwable : RigidBody3D ) -> void:
	print("Pick it up!")
	holding_throwable = throwable
	holding_throwable.freeze = true
	holding_throwable.reparent(PICKUP_POINT)
	holding_throwable.position = Vector3.ZERO
	is_holding = true

func throw_throwable() -> void:
	print("Throwing")
	is_holding = false
	holding_throwable.freeze = false
	holding_throwable.linear_velocity = get_parent().transform.basis * CAM.transform.basis * Vector3(0, 1, -20)
	holding_throwable.reparent(get_tree().current_scene)
	holding_throwable = null

func reload_ammo() -> void:
	print("Reload Done!")
	is_reloading = false
	current_plasma_ammo = MAX_PLASMA_GUN_AMMO

func spawn_plasma_bullet() -> void:
	var p = PLASMA_BULLET.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = PLASMA_GUN_BARREL_POINT.global_position
	p.rotation = PLASMA_GUN_BARREL_POINT.global_rotation
