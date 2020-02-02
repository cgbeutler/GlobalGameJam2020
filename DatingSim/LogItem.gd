extends Control

export var logText = "Enter text" 

enum {said,will_say, they_said}

export var type = they_said;
# Declare member variables here. Examples:

signal queueDeletion()

#var choice = load("res://DatingSim/style_log_choice.tres") as StyleBoxFlat
#var choiceHovered = load("res://DatingSim/style_log_choice_hovered.tres") as StyleBoxFlat
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func style():
	if type == they_said:
		$Button.add_stylebox_override("disabled", load("res://DatingSim/style_log_them.tres") as StyleBoxFlat)	
		$Button.disabled = true
	else: if type == said:
		$Button.add_stylebox_override("disabled", load("res://DatingSim/style_log.tres") as StyleBoxFlat)	
#		self.theme.set_color("")		
		$Button.disabled = true		
	else: if type == will_say:
		$Button.add_stylebox_override("disabled", load("res://DatingSim/style_log_choice.tres") as StyleBoxFlat)	

func _ready():
	var margin_value = 15
	$MarginContainer.set("custom_constants/margin_left", margin_value)
	$MarginContainer.set("custom_constants/margin_bottom", margin_value)
	$MarginContainer.set("custom_constants/margin_right", margin_value)
	$MarginContainer.set("custom_constants/margin_top", margin_value)
	$MarginContainer/Label.text = logText
	style()

		
	pass # Replace with function body.



func _on_Button_pressed():
	print ("You chose " + logText)
	$"..".emit_signal("choiceMade",logText)
	pass # Replace with function body.


func _on_Control_queueDeletion():
	queue_free()
	pass # Replace with function body.
