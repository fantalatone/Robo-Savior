extends Item

func start_use():
	super.start_use()
	if INTERACTION.is_colliding():
		var obj = INTERACTION.get_collider()
		if obj.is_in_group("Fragiles"):
			if obj.item_type == type:
				obj._try_to_fix()
