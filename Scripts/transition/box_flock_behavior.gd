extends CSGBox

var time_to_start = 4
var time = 0
var startY

func _ready():
	startY = translation.y

func _process(delta):
	time += delta
	if time > time_to_start:
		if translation.x < -15:
			translation.x = 15
		else:
			translation.x -= 3 * delta
			translation.y = startY + sin(translation.x)
