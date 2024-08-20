extends CharacterBody3D
class_name Robot

const MOVEMENT_SPEED = 7.0
const THRUSTER_POWER = 20

const MOUSE_SENSIVITY : float = 0.5

@onready var CAM : Camera3D =  %Camera
@onready var ANIMATION : AnimationPlayer = $Animation

@onready var WEAPONS : WeaponsController = $Weapons
@onready var HEALTH : HealthSystem = $"Health System"

var camera_pitch : float = 0.0

var is_being_controlled : bool = false

static var instance : Robot

func _ready() -> void:
	instance = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * get_gravity_multiplier() * delta 

	if Input.is_action_pressed("fly") and is_being_controlled: handle_flight(delta)

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if is_being_controlled:
			velocity.x = direction.x * MOVEMENT_SPEED
			velocity.z = direction.z * MOVEMENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVEMENT_SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _damage(): 
	HEALTH._damage()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_being_controlled:
		handle_camera_and_body(event.relative)

# Handle left mouse button event
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload") and is_being_controlled:
		WEAPONS.handle_reload()
	
	if event is InputEventMouseButton and is_being_controlled:
		WEAPONS.handle_actions( event )
	
# Get gravity multiplier
func get_gravity_multiplier() -> float:
	return 1.5 if velocity.y > 0 else 4.0

#func handle_sword() -> void:
	#ANIMATION.play("slash")

#func handle_gun( pressed : bool, released : bool ) -> void: 
	#if pressed:
		#is_using_gun = true
		#if current_gun_mode == GUN_MODE.PLASMA:
			#plasma_gun_timer = 0.1
			#return
	#if released:
		#is_using_gun = false
		#if raygun_timer > 0.75:
			#raygun()
			#raygun_timer = 0.0

#func raygun() -> void:
	#if RAY.is_colliding():
		#print("Raygun Attack ", RAY.get_collider())

func handle_flight( delta : float ) -> void:
	velocity.y = THRUSTER_POWER / 5.0

func handle_camera_and_body( relative : Vector2 ) -> void:
	rotation_degrees.y += relative.x * -1 * MOUSE_SENSIVITY
	camera_pitch += relative.y * -1 * MOUSE_SENSIVITY
	camera_pitch = clamp(camera_pitch, -70, 70)
	CAM.rotation_degrees.x = camera_pitch

#func switch_guns() -> void:
	#current_gun_mode = GUN_MODE.PLASMA if current_gun_mode == GUN_MODE.RAYGUN else GUN_MODE.RAYGUN

#func pickup() -> void:
	#if PICKUP_RAY.is_colliding():
		#var obj = PICKUP_RAY.get_collider()
		#if obj.is_in_group("Throwables"):
			#is_holding_throwable = true
			#throwable = obj
			#throwable.freeze = true
			#throwable.reparent(PICKUP_POINT)
			#throwable.position = Vector3.ZERO
			#throwable.linear_velocity = Vector3.ZERO
#
#func throw() -> void:
	#throwable.reparent(get_tree().current_scene)
	#throwable.freeze = false
	#throwable.linear_velocity = (transform.basis * CAM.transform.basis * Vector3(0, 0.5, -20))
	#throwable = null
	#is_holding_throwable = false

func _disable_input() -> void:
	CAM.clear_current()
	is_being_controlled = false

func _enable_input() -> void:
	CAM.make_current()
	is_being_controlled = true

# SIGNALS
func _on_anim_finished(anim_name: StringName) -> void:
	if anim_name == "slash":
		ANIMATION.play("idle")

func _on_sword_entered_body(body: Node3D) -> void:
	print("Sword Attack ", body )
