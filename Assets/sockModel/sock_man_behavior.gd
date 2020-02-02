extends Spatial

var startX

onready var animation_player = $AnimationPlayer
func _ready():
	var animation = animation_player.get_animation("Armature|Talk")
	animation.set_loop(true)
	animation_player.play("Armature|Talk")
	startX = translation.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#rotation.y += 0.01
	if translation.z < -15:
		translation.z = 15
	else:
		translation.z += 0.03
		translation.x = startX + sin(translation.z)
