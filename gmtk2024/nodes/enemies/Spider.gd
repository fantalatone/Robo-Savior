extends Enemy

var robot

@onready var ANIM: AnimationPlayer = $Spider/AnimationPlayer
@onready var AGENT: NavigationAgent3D = $Agent

@onready var ATTACK_POINT : Marker3D = $"Attack Point"
@onready var ATTACK_SPHERE := preload("res://nodes/player/bullet/melee_attack.tscn")

var should_attack : bool = false
var prev_should_attack : bool = true

const SPEED = 6.5

var feedback_timer : Timer = Timer.new()

func _ready() -> void:
	
	robot = Robot.instance
	ANIM.play("IDLE")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * 2.0 * delta
	
	AGENT.target_position = robot.global_position
	should_attack = global_position.distance_to(robot.global_position) <= 3.0
	if prev_should_attack != should_attack:
		prev_should_attack = should_attack
		if should_attack:
			ANIM.play("ATTACK")
	
	var next = AGENT.get_next_path_position()
	if not should_attack and is_on_floor():
		var dir = (next - global_position).normalized()
		
		velocity = dir * SPEED
		
		ANIM.play("WALK")

	if should_attack:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	var dir = next - global_position
	var v = Vector3.UP.cross(-next.normalized())
	
	if not v.is_equal_approx(Vector3.ZERO):
		if not Vector3.UP.cross(dir).is_equal_approx(Vector3.ZERO):
			look_at(next, Vector3.UP)
			rotation.x = 0.0
	
	move_and_slide()

func _damage( amount: int ) -> void:
	super._damage(amount)
	velocity = Vector2.ZERO

func attack() -> void:
	var b : Node3D = ATTACK_SPHERE.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = ATTACK_POINT.global_position
