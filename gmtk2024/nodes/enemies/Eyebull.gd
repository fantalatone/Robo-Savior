extends Enemy

var attack_timer : Timer = Timer.new()

var desired_height : float = 15
var should_change_height : bool = false

var has_lunged : bool = false

var robot

var timer_t : Timer = Timer.new()

const SPEED : int = 6.0

func _ready() -> void:
	super._ready()
	timer_t.one_shot = true
	timer_t.timeout.connect(func(): 
		desired_height = 15 
		has_lunged = false)
	add_child(timer_t)
	
	robot = Robot.instance

func lunge_to_robot():
	if global_position.distance_to(robot.global_position) <= 50:
		velocity = (robot.global_position - global_position).normalized() * 35.0

func _physics_process(delta: float) -> void:
	if not robot: robot = Robot.instance
	
	
	if global_position.distance_to(robot.global_position) > 30:
		velocity = (robot.global_position - global_position).normalized() * SPEED
	else: 
		if not has_lunged:
			lunge_to_robot()
			has_lunged = true
			desired_height = robot.global_position.y + 1.5
			timer_t.start(5)
	
	velocity.y = (desired_height - global_position.y)
	
	move_and_slide()
	look_at(robot.global_position)
