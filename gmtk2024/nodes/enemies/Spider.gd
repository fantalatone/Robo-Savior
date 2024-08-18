extends Enemy

var robot

@onready var ANIM: AnimationPlayer = $Spider/AnimationPlayer
@onready var AGENT: NavigationAgent3D = $Agent
@onready var ATTACK_POINT : Marker3D = $"Attack Point"
@onready var ATTACK_SPHERE := preload("res://nodes/player/bullet/melee_attack.tscn")

var should_attack_robot : bool = false
var attack_timer : Timer = Timer.new()
var attack_cooldown : Timer = Timer.new()

const SPEED = 5.0

func _ready() -> void:
	attack_timer.one_shot = true
	attack_timer.timeout.connect(attack)
	add_child(attack_timer)
	
	attack_cooldown.one_shot = true
	add_child(attack_cooldown)
	
	robot = Robot.instance
	ANIM.play("Armature|IDLE")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * 2.0 * delta
	
	should_attack_robot = global_position.distance_to(robot.global_position) <= 3
	AGENT.target_position = robot.global_position
	
	if not should_attack_robot and is_on_floor():
		var next = AGENT.get_next_path_position()
		var dir = (next - global_position).normalized()
		
		velocity = dir * SPEED
	
	var dir = global_position.direction_to(robot.global_position)
	var angle = Vector2(dir.x, dir.z).angle()
	
	rotation.y = move_toward(rotation.y, angle, delta * 100.0)
	
	move_and_slide()

func attack() -> void:
	pass

func _on_animation_finished(anim_name: StringName) -> void:
	pass
