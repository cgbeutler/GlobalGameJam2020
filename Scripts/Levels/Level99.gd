extends Level

func play_ending():
	$AnimationPlayer.play("Lonely")

func on_lonely_anim_done():
	$"../".on_ending_anim_done()
