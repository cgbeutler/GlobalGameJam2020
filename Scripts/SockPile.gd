extends Node
var Sock = preload("Sock.gd")

var starting_sock_count : int
var sock_count : int

func _ready() -> void:
	for child in get_children():
		if child is Sock:
			starting_sock_count += 1
	sock_count = starting_sock_count

func collect_pair( sock_1, sock_2 ):
	# TODO: Spawn congrats message or something?
	sock_1.queue_free()
	sock_2.queue_free()
	sock_count -= 2
	
	if sock_count == 0:
		print( "You Win!" )
		get_tree().quit()
