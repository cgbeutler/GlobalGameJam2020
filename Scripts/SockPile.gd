extends Node
var Sock = preload("Sock.gd")

var rng = RandomNumberGenerator.new()
var starting_sock_count : int
var sock_count : int
onready var sock_match_audio = $"Sock_Match_Audio"
onready var texts_container_node = $"Texts"

func _ready() -> void:
	rng.randomize()
	for child in get_children():
		if child is Sock:
			starting_sock_count += 1
	sock_count = starting_sock_count

func claim_sock_id() -> int:
	sock_count += 1
	return sock_count - 1

func collect_pair( sock_1, sock_2 ):
	sock_1.queue_free()
	sock_2.queue_free()
	sock_count -= 2

	var n_texts = texts_container_node.get_child_count();
	var rand_text_idx = rng.randi_range(0, n_texts - 1)
	print(rand_text_idx)
	var text_sprite = texts_container_node.get_child(rand_text_idx)
	var avg_position = (sock_1.position + sock_2.position) / 2
	text_sprite.position = avg_position
	text_sprite.show()

	if sock_count == 0:
		print( "You Win!" )
		get_tree().quit()
	else:
		sock_match_audio.play()
