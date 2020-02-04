extends Node

signal trigger(eventName)

export var json_file = "res://DatingSim/dating_tree.json"

onready var vbox := $MarginContainer/Control/Panel/ScrollContainer/VBoxContainer

func _ready() -> void:
	var file = File.new()
	file.open(json_file, file.READ)
	var content = file.get_as_text()
	file.close()
	
	var parsed := JSON.parse(content)
	if not parsed.error:  vbox.start_sim(parsed.result)
	else:  push_error( "Error? " + (parsed.error_string))

func _on_VBoxContainer_triggered(message):
	print("triggered " + message)
	if (message == "pair on"):
		$Button.disabled = false
	else:
		emit_signal("trigger", message)

# VICTORY!!!
func _on_Button_pressed():
	print("WINNNN!")
	get_tree().change_scene("res://EndMinigame.tscn")
