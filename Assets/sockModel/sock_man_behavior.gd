extends Spatial

var time_to_start = 4
var time = 0
var startX

onready var animation_player = $AnimationPlayer
func _ready():
	var animation = animation_player.get_animation("Armature|Talk")
	animation.set_loop(true)
	animation_player.play("Armature|Talk", -1, 0.4)
	startX = translation.x

func _process(delta):
	time += delta
	if time > time_to_start:
		if translation.z < -15:
			translation.z = 15
		else:
			translation.z += 1.8 * delta
			translation.x = startX + sin(translation.z)
