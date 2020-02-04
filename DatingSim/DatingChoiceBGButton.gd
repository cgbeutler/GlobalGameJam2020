extends Button
var StyleChoiceNormal : StyleBoxFlat = preload("res://DatingSim/style_log_choice.tres")
var StyleChoiceHovered : StyleBoxFlat = preload("res://DatingSim/style_log_choice_hovered.tres")

func _on_ButtonCover_mouse_entered():
	disabled = true
	add_stylebox_override("disabled", StyleChoiceHovered )

func _on_ButtonCover_mouse_exited():
	disabled = true
	add_stylebox_override("disabled", StyleChoiceNormal )
