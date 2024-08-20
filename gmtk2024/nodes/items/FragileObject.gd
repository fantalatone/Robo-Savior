extends StaticBody3D
class_name FragileObject

@export var item_type : Interaction.ITEM_TYPE

var damage : int = 0

@export_group("Misc")
@export var FIX_COUNT : int = 3
var fix_tick : int = 0

func _broke_one_level() -> void:
	Robot.instance.HEALTH._add_damage_point(1)
	damage += 1
	if damage > 2:
		damage = 2
	_update_visuals()

func _fix_one_level() -> void:
	Robot.instance.HEALTH._remove_damage_point()
	damage -= 1
	if damage < 0:
		damage = 0
	_update_visuals()

func _try_to_fix() -> void:
	if damage == 0: return
	fix_tick += 1
	if fix_tick >= FIX_COUNT:
		fix_tick = 0
		_fix_one_level()

func _update_visuals():
	pass
