extends Enemy

var robot

@onready var ANIM: AnimationPlayer = $Spider/AnimationPlayer
@onready var AGENT: NavigationAgent3D = $Agent
@onready var ATTACK_POINT : Marker3D = $"Attack Point"

@onready var ATTACK_SPHERE := preload("res://nodes/player/bullet/melee_attack.tscn")

var should_attack_robot : bool = false

const SPEED = 5.0

func _ready() -> void:
	robot = Robot.instance
	ANIM.play("Armature|Idle_Anim")

func _physics_process(delta: float) -> void:
	
	#for bone in get_node("Spider/Armature/Skeleton3D").get_children():
		#get_node(bone).transform = get_node("Spider/Armature/Skeleton3D/" + bone).transform
	
	should_attack_robot = AGENT.distance_to_target() <= 4
	
	if not is_on_floor():
		velocity += get_gravity() * 2.0 * delta
		
	if is_on_floor() and not should_attack_robot:
		AGENT.target_position = robot.global_position
		var next_point = AGENT.get_next_path_position()
		velocity = (next_point - global_position).normalized() * SPEED
		ANIM.play("Armature|Walk")
		look_at(robot.position, Vector3.UP)
		
	move_and_slide()
	
	if should_attack_robot:
		ANIM.play("Armature|Attack")
		if ANIM.current_animation_position >= 1:
			var a = ATTACK_SPHERE.instantiate()
			get_tree().current_scene.add_child(a)
			a.global_position = ATTACK_POINT.global_position
