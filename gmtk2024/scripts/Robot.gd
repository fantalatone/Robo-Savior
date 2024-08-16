extends CharacterBody3D
class_name Robot

const SPEED = 5.0
const JUMP_VELOCITY = 15

const MOUSE_SENSIVITY : float = 0.5

@onready var CAM : Camera3D = $Camera
var camera_pitch : float = 0.0

@onready var GunRay : RayCast3D = $"Camera/Gun/Gun Ray"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("fly"): handle_flight(delta)

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			handle_gun()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_camera_and_body(event.relative)

func handle_gun() -> void: 
	if GunRay.is_colliding():
		print(GunRay.get_collider())

func handle_flight( delta : float ) -> void:
	velocity.y += JUMP_VELOCITY * delta

func update_camera_and_body( relative : Vector2 ) -> void:
	rotation_degrees.y += relative.x * -1 * MOUSE_SENSIVITY
	camera_pitch += relative.y * -1 * MOUSE_SENSIVITY
	camera_pitch = clamp(camera_pitch, -70, 70)
	CAM.rotation_degrees.x = camera_pitch
