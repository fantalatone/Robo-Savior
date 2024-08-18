extends Node

var SCORE : int : 
	set(a): 
		SCORE = a
		update_ui()

func score_up( amount: int ) -> void:
	SCORE += amount

func update_ui() -> void:
	GUIController.instance.SCORE_LABEL.text = str(SCORE)
