extends Area3D
class_name Bullet

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -150) * delta

func _on_timeout() -> void:
	queue_free()
