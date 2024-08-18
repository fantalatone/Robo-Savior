extends Item

func start_use():
	super.start_use()
	if INTERACTION.is_colliding():
		var obj = INTERACTION.get_collider()
		if obj.is_in_group("Fragiles"):
			obj._heal(10)
			obj._update_visuals()
