extends Interaction

signal button_press 

func _press() -> void:
	#print("Press")
	#ScaleManager._change_scale()
	button_press.emit()
