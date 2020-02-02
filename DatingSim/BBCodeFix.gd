extends Button

enum {said,will_say, they_said}

var mouseOver: bool
var isInteractive = false

func style(type):
	if type == they_said:
		add_stylebox_override("disabled", load("res://DatingSim/style_log_them.tres") as StyleBoxFlat)	
		disabled = true
	else: if type == said:
		add_stylebox_override("disabled", load("res://DatingSim/style_log.tres") as StyleBoxFlat)	
#		self.theme.set_color("")		
		disabled = true		
	else: if type == will_say:
		disabled = true		
		isInteractive = true
		if mouseOver:
			print("mouse over")
			add_stylebox_override("disabled", load("res://DatingSim/style_log_choice_hovered.tres") as StyleBoxFlat)
		else:
			print("mouse off")
			add_stylebox_override("disabled", load("res://DatingSim/style_log_choice.tres") as StyleBoxFlat)	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonCover_mouse_entered():
	if (not isInteractive): return
	self.emit_signal("mouse_entered")
	mouseOver = true	
	style(will_say)
	pass # Replace with function body.


func _on_ButtonCover_mouse_exited():
	if (not isInteractive): return
	self.emit_signal("mouse_exited")
	mouseOver = false
	style(will_say)
	pass # Replace with function body.


func _on_Control_styleButton(butType):
	style(butType)
