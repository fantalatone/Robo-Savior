extends Enemy

var robot

@onready var ANIM: AnimationPlayer = $Spider/AnimationPlayer
@onready var AGENT: NavigationAgent3D = $Agent

@onready var ATTACK_POINT : Marker3D = $"Attack Point"
@onready var ATTACK_SPHERE := preload("res://nodes/player/bullet/melee_attack.tscn")

var should_attack : bool = false
var prev_should_attack : bool = true

const SPEED = 5.0

func _ready() -> void:
	robot = Robot.instance
	ANIM.play("IDLE")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * 2.0 * delta
	
	AGENT.target_position = robot.global_position
	should_attack = global_position.distance_to(robot.global_position) <= 3.5
	if prev_should_attack != should_attack:
		prev_should_attack = should_attack
		if should_attack:
			ANIM.play("ATTACK")
	
	if not should_attack and is_on_floor():
		var next = AGENT.get_next_path_position()
		var dir = (next - global_position).normalized()
		
		velocity = dir * SPEED
		
		ANIM.play("WALK")

	if should_attack:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	look_at(robot.global_position)
	rotation.x = 0.0
	
	move_and_slide()

func attack() -> void:
	var b : Node3D = ATTACK_SPHERE.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = ATTACK_POINT.global_position
