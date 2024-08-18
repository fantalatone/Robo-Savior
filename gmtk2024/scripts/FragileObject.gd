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

@onready var DECAL : Decal = $Decal
@onready var MESH : MeshInstance3D = $Mesh

func _ready() -> void:
	if not is_decal:
		DECAL.hide()
		DECAL.process_mode = Node.PROCESS_MODE_DISABLED
		MESH.mesh = low_damage_mesh
		return

func _update_visuals():
	if is_decal:
		if health > 0 and health <= 30:
			DECAL.texture_albedo = high_damage_decal
		if health > 30 and health <= 70:
			DECAL.texture_albedo = medium_damage_decal
		if health > 70:
			DECAL.texture_albedo = low_damage_decal
		return
	if health > 0 and health <= 30:
		MESH.mesh = high_damage_mesh
	if health > 30 and health <= 70:
		MESH.mesh = medium_damage_mesh
	if health > 70:
		MESH.mesh = low_damage_mesh
