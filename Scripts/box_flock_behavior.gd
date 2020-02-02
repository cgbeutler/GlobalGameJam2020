extends CSGBox

var time_to_start = 4
var time = 0
var startY

func _ready():
	startY = translation.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > time_to_start:
		if translation.x < -15:
			translation.x = 15
		else:
			translation.x -= 0.06
			translation.y = startY + sin(translation.x)
