extends Spatial

onready var animation_player = $AnimationPlayer

func play_animation(animation_name):
	var animation = animation_player.get_animation(animation_name)
	animation.set_loop(false)
	animation_player.play(animation_name)

func play_talk():
	play_animation("Armature|Talk")

func play_dontgothere():
	play_animation("Armature|dontgothere")

func play_eee():
	play_animation("Armature|eee")

func play_groove():
	play_animation("Armature|groove")

func play_no():
	play_animation("Armature|no")

func play_nod():
	play_animation("Armature|nod")

func play_nod1():
	play_animation("Armature|nod.001")

func play_nod2():
	play_animation("Armature|nod.002")

func play_pissed():
	play_animation("Armature|pissed")

func play_pissed1():
	play_animation("Armature|pissed.001")

func play_shock():
	play_animation("Armature|shock")

func play_splosion():
	play_animation("Armature|splosion")

func play_turn():
	play_animation("Armature|turn")

func _on_Control_trigger(eventName):
	print("anim trigger "+ eventName)
	if eventName == "sad":
		play_pissed1()
	else: if eventName == "shock":
		play_splosion()
	else: if eventName == "sexy":
		play_turn()
