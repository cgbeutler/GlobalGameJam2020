extends Node


func collect_pair( sock_1, sock_2 ):
	# TODO: Spawn congrats message or something?
	sock_1.queue_free()
	sock_2.queue_free()
	
	if get_child_count() == 2:
		print( "You Win!" )
		get_tree().quit()
