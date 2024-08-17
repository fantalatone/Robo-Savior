extends Item

@onready var smoke = preload("res://extinguisher_smoke.tscn")

func use():
	super.use()
	var i = smoke.instantiate()
	get_tree().current_scene.add_child(i)
	i.global_position = global_position
