extends Item

func start_use():
	super.start_use()

func _process(delta: float) -> void:
	if is_being_used and INTERACTION.is_colliding():
		var obj = INTERACTION.get_collider()
		if obj.is_in_group("Fragiles"):
			obj._heal(delta * 10)
