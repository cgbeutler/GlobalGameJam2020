extends Node

export var json_file = "res://DatingSim/dating_tree.json"

signal trigger(eventName)




func _on_VBoxContainer_triggered(message):
	print("triggered " + message)
	if (message == "pair on"):
		$Button.disabled = false
	pass # Replace with function body.

func _on_Control_trigger(eventName):
	print("PAIRED")
	if (eventName == "pair on"):
		$Button.disabled = false
	pass # Replace with function body.


# VICTORY!!!
func _on_Button_pressed():
	print("WINNNN!")
	get_tree().change_scene("res://EndMinigame.tscn")
	pass # Replace with function body.
