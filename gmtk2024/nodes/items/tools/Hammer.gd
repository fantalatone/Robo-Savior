extends Item

func start_use():
	super.start_use()
	if INTERACTION.is_colliding():
		var obj = INTERACTION.get_collider()
		if obj.is_in_group("Fragiles"):
			obj._heal(10)
			Robot.instance.HEALTH._heal(50)
			obj._update_visuals()
