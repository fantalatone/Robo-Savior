extends FragileObject

@onready var SPRITE : Sprite3D = $Sprite

@export_group("Decal Settings")
@export var high_damage_decal : Texture2D
@export var medium_damage_decal : Texture2D
@export var low_damage_decal : Texture2D

func _update_visuals():
	if damage == 0:
		SPRITE.texture = low_damage_decal
	if damage == 1:
		SPRITE.texture = medium_damage_decal
	if damage == 2:
		SPRITE.texture = high_damage_decal
