extends CharacterBody3D

@onready var robot: Node3D = $"../Robot"
@onready var animation_player: AnimationPlayer = $Slime/AnimationPlayer
var speed: float = 5.0  # Speed at which the chaser moves

func _ready() -> void:
	animation_player.play("Walk")
	var anim = animation_player.get_animation("Walk")
	anim.loop = true

func _physics_process(delta: float) -> void:
	
	move_and_slide()
	if not is_on_floor():
		velocity += get_gravity() * delta 
	
	if robot: # Chase Robot
		var direction = (robot.position - position).normalized()
		var desired_velocity = direction * speed
		velocity.x = move_toward(velocity.x, desired_velocity.x, speed * delta)
		velocity.z = move_toward(velocity.z, desired_velocity.z, speed * delta)
		look_at(robot.position)
		
# add bullet logic
	
