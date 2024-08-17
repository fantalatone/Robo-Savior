extends CharacterBody3D
class_name Player

const MOUSE_SENSIVITY : float = 0.3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var CAM : Camera3D = $Camera
var camera_pitch : float = 0.0

var is_on_ladder: bool = false

@onready var INTERACTION_RAY : RayCast3D = $Camera/Interaction
@onready var HAND : Marker3D = $Camera/Hand

var is_holding_something : bool = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_ladder:
		velocity.y = -direction.z * SPEED
	
	if direction:
		velocity.x = direction.x * SPEED
		if not is_on_ladder:
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			handle_item()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_camera_and_body(event.relative)

func handle_item() -> void:
	if INTERACTION_RAY.is_colliding():
		var obj : Node3D = INTERACTION_RAY.get_collider()
		if obj.is_in_group("Interactions"):
			var visual_mesh : MeshInstance3D = obj.find_child("Visual")
			visual_mesh.reparent(HAND)
			visual_mesh.position = Vector3.ZERO
			is_holding_something = true
			obj.queue_free()
		if is_holding_something and obj.type == Interaction.INTERACTION_TYPE.PROBLEM:
			obj.queue_free()

func update_camera_and_body( relative : Vector2 ) -> void:
	rotation_degrees.y += relative.x * -1 * MOUSE_SENSIVITY
	camera_pitch += relative.y * -1 * MOUSE_SENSIVITY
	camera_pitch = clamp(camera_pitch, -70, 70)
	CAM.rotation_degrees.x = camera_pitch
