extends Sprite

var frames_left = 60

func _draw():
	frames_left = 60
	modulate.a = 1

func _process( _delta : float ) -> void:
	if is_visible():
		position.y -= 0.6
		modulate.a -= 0.016
		frames_left -= 1
		if frames_left <= 0:
			hide()
