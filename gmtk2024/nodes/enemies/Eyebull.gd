extends Enemy

var attack_timer : Timer = Timer.new()

var desired_height : float = 30
var should_change_height : bool = false

var robot

func _ready() -> void:
	add_child(attack_timer)
	attack_timer.timeout.connect(lunge_to_robot)
	#attack_timer.start(5)
	
	robot = Robot.instance

func lunge_to_robot():
	if global_position.distance_to(robot.global_position) <= 50:
		velocity = (robot.global_position - global_position).normalized() * 20.0

func _physics_process(delta: float) -> void:
	if not robot: robot = Robot.instance
	
	look_at(robot.global_position)
