extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.is_on_ladder = true

func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.is_on_ladder = false
