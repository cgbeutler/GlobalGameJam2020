extends Node

export var json_file = "res://DatingSim/dating_tree.json"

signal trigger(eventName)




func _on_VBoxContainer_triggered(message):
	print("triggered " + message)
