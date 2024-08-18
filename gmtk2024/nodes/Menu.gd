extends Control
class_name Menu


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/maps/game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
