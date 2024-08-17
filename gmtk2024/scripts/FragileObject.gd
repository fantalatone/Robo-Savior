extends StaticBody3D
class_name FragileObject

@export var item_type : Interaction.ITEM_TYPE
@export var is_decal : bool = false

@export_group("Decal Settings")
@export var high_damage_decal : Texture2D
@export var medium_damage_decal : Texture2D
@export var low_damage_decal : Texture2D

@export_group("Mesh Settings")
@export var high_damage_mesh : Mesh
@export var medium_damage_mesh : Mesh
@export var low_damage_mesh : Mesh

const MAX_HEALTH : int = 100
var health : float = 100
