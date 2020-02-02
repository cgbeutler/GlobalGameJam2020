extends VideoPlayer

func _on_VideoPlayer_finished():
	var music_ctrl = get_node("/root/Background_Music_Ctrl")
	music_ctrl.Start_Dating_Music()
	get_tree().change_scene("res://DatingGameScene1.tscn")
