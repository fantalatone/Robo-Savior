extends Interaction

signal button_press 

func _press() -> void:
	button_press.emit()
