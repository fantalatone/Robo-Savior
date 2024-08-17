extends Node3D
class_name Item

@export var type : Interaction.ITEM_TYPE
@export var mesh : MeshInstance3D
@export var animation : MeshInstance3D

var is_being_used : bool = false

func use():
	is_being_used = true

func stop_use():
	is_being_used = false
