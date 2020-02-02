extends CSGBox

var startY

func _ready():
	startY = translation.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if translation.x < -15:
		translation.x = 15
	else:
		translation.x -= 0.06
		translation.y = startY + sin(translation.x)
