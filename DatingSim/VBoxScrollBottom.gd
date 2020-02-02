extends VBoxContainer

signal choiceMade(caller)

var activeChoices: Array

enum {said,will_say, they_said}
var parent : ScrollContainer



var json
var logBase = preload("res://DatingSim/DatingLog.tscn")

func getJSON():
	var file = File.new()
	
	file.open($"../../../../..".json_file, file.READ)
	var content = file.get_as_text()
	json = JSON.parse(content)
	
	print ( "Error? " + (json.error_string))
	
	json = json.result
	
func loadChoice():
	if json.has("trigger_scene"):
		print ("triggering new Scene..")
		get_tree().change_scene(json["trigger_scene"])
		return
	if json.has("choice"):
		var curLog = logBase.instance()
		print (json["choice"])
		curLog.logText = json["choice"]
		curLog.type = said
		curLog.style()
		self.add_child(curLog)
	
	var dateResponse = logBase.instance()
	print (json["response"])
	dateResponse.logText = json["response"]
	dateResponse.type = they_said
	dateResponse.style()
	self.add_child(dateResponse)
	
	activeChoices.clear()
	
	for choice in json["nextChoices"]:
		var childChoice = logBase.instance()
		childChoice.logText = choice["choice"]		
		childChoice.type = will_say
		childChoice.style()
		activeChoices.append(childChoice)
		self.add_child(childChoice)
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	getJSON()	
	loadChoice()
	parent = $".."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parent.scroll_vertical = 99999

#	pass




func _on_VBoxContainer_choiceMade(choiceText):
#	caller.get_child(0).disabled = true
#	self.add_child(caller.duplicate())
	
	for c in json["nextChoices"]:
		if c["choice"] == choiceText:
			json = c
			break
	
	for i in activeChoices:	
		i.call("_on_Control_queueDeletion")	
		
	loadChoice()
	#loadChoice(false)
	pass # Replace with function body.
