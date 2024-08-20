extends CharacterBody3D
class_name Robot

const MOVEMENT_SPEED = 7.0
const THRUSTER_POWER = 12

const MOUSE_SENSIVITY : float = 0.5

@onready var CAM : Camera3D =  %Camera

@onready var WEAPONS : WeaponsController = $Weapons
@onready var HEALTH : HealthSystem = $"Health System"

@onready var FOOTSTEPS : FmodEventEmitter3D = $"Footsteps"
@onready var JUMP : FmodEventEmitter3D = $"Jump"

var camera_pitch : float = 0.0

var is_being_controlled : bool = false

static var instance : Robot

var f_t : Timer = Timer.new()

func _ready() -> void:
	f_t.one_shot = false
	add_child(f_t)
	f_t.start(1.0)
	f_t.timeout.connect(footstep)
	
	instance = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func footstep() -> void:
	if (velocity.x != 0 and velocity.z != 0) and velocity.y == 0:
		FOOTSTEPS.set_parameter("Scale Change", 1)
		FOOTSTEPS.play()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * get_gravity_multiplier() * delta 

	if Input.is_action_pressed("fly") and is_being_controlled and is_on_floor(): 
		handle_flight(delta)
		JUMP.play()

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

func _damage(): 
	get_node("Robot Damage Sound").play()
	HEALTH._damage()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_being_controlled:
		handle_camera_and_body(event.relative)

# Handle left mouse button event
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("change_scale"):
		ScaleManager._change_to_human()
	
	if Input.is_action_just_pressed("reload") and is_being_controlled:
		WEAPONS.handle_reload()
	
	if event is InputEventMouseButton and is_being_controlled:
		WEAPONS.handle_actions( event )
	
# Get gravity multiplier
func get_gravity_multiplier() -> float:
	return 1.5 if velocity.y > 0 else 4.5

func handle_flight( delta : float ) -> void:
	velocity.y = THRUSTER_POWER

func handle_camera_and_body( relative : Vector2 ) -> void:
	rotation_degrees.y += relative.x * -1 * MOUSE_SENSIVITY
	camera_pitch += relative.y * -1 * MOUSE_SENSIVITY
	camera_pitch = clamp(camera_pitch, -70, 70)
	CAM.rotation_degrees.x = camera_pitch

func _disable_input() -> void:
	CAM.clear_current()
	is_being_controlled = false

func _enable_input() -> void:
	CAM.make_current()
	is_being_controlled = true

func _disable_audio() -> void:
	FOOTSTEPS.set_parameter("Scale Change", 0)

func _enable_audio() -> void:
	FOOTSTEPS.set_parameter("Scale Change", 1)
