extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Robot:
		body._damage()

func _on_timer_timeout() -> void:
	queue_free()
