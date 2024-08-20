extends FragileObject

@onready var DECAL : Decal = $Decal

@export_group("Decal Settings")
@export var high_damage_decal : Texture2D
@export var medium_damage_decal : Texture2D
@export var low_damage_decal : Texture2D

func _update_visuals():
	if damage == 0:
		DECAL.texture_albedo = low_damage_decal
	if damage == 1:
		DECAL.texture_albedo = medium_damage_decal
	if damage == 2:
		DECAL.texture_albedo = high_damage_decal
