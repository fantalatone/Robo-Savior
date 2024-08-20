extends Control

func _input(event: InputEvent) -> void:
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://nodes/maps/game.tscn")
