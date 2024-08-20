extends CharacterBody3D
class_name Player

const MOUSE_SENSIVITY : float = 0.3

const SPEED = 5.0
const JUMP_VELOCITY = 5.5

@onready var CAM : Camera3D = $Camera
var camera_pitch : float = 0.0

@onready var INTERACTION_RAY : RayCast3D = $Camera/Interaction
@onready var HAND : Marker3D = $Camera/Hand

var is_being_controlled : bool = true
var is_holding_item : bool = false

var holding_item_type : Interaction.ITEM_TYPE
@onready var ITEMS_CONTROLLER : ItemsController = $Items

#@onready var LISTENER : FmodListener3D = $Listener
@onready var FOOTSTEPS : FmodEventEmitter3D = $"Footstep Sound"

func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	#Robot.instance.HEALTH.damage_taken.connect(func(): print("Hi from player"))
	
	if not is_on_floor():
		velocity += get_gravity() * delta * 3.0

	if not get_tree().current_scene.find_child("Interior").visible: return
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction and is_being_controlled:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if randf() < 0.01:
			FOOTSTEPS.play()
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
		if event.is_released() and is_holding_item:
			ITEMS_CONTROLLER.stop_using_item(holding_item_type)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_being_controlled:
		update_camera_and_body(event.relative)

func handle_interactions() -> bool:
	if INTERACTION_RAY.is_colliding():
		var obj = INTERACTION_RAY.get_collider()
		if obj.is_in_group("Items"): 
			if obj.type == Interaction.INTERACTION_TYPE.BUTTON: 
				obj._press()
				return true
			interact_with_items(obj)
			return true
		return false
	return false

func interact_with_items( interaction : ItemInteraction ) -> void:
	if not is_holding_item:
		if interaction._take_item():
			holding_item_type = interaction.item_type
			ITEMS_CONTROLLER.show_tool( holding_item_type )
			is_holding_item = true
		return
	
	if holding_item_type == interaction.item_type:
		if interaction._drop_item():
			ITEMS_CONTROLLER.hide_tools()
			holding_item_type = Interaction.ITEM_TYPE.NULL
			is_holding_item = false

func use_item() -> void:
	ITEMS_CONTROLLER.start_using_item(holding_item_type)

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
