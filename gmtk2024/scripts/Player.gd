extends CharacterBody3D
class_name Player

const MOUSE_SENSIVITY : float = 0.3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var CAM : Camera3D = $Camera
var camera_pitch : float = 0.0

@onready var INTERACTION_RAY : RayCast3D = $Camera/Interaction
@onready var HAND : Marker3D = $Camera/Hand

var is_being_controlled : bool = true
var is_holding_item : bool = false

var holding_item_type : Interaction.ITEM_TYPE

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction and is_being_controlled:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_being_controlled:
		if event.is_pressed():
			if not handle_interactions() and is_holding_item:
				use_item()
		if event.is_released():
			pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_being_controlled:
		update_camera_and_body(event.relative)

func handle_interactions() -> bool:
	if INTERACTION_RAY.is_colliding():
		var obj = INTERACTION_RAY.get_collider()
		if obj.is_in_group("Items"): 
			interact_with_items(obj)
			return true
		return false
	return false

func interact_with_items( interaction : ItemInteraction ) -> void:
	if not is_holding_item:
		is_holding_item = true
		holding_item_type = interaction.item_type
		interaction._take_item()
		return
	
	if holding_item_type == interaction.item_type:
		interaction._drop_item()
		holding_item_type = Interaction.ITEM_TYPE.NULL
		is_holding_item = false

func use_item() -> void:
	match holding_item_type:
		Interaction.ITEM_TYPE.BLOWTORCH:
			print("Fire!")
		Interaction.ITEM_TYPE.DUCT_TAPE:
			print("I hope it keeps it!")

func update_camera_and_body( relative : Vector2 ) -> void:
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
