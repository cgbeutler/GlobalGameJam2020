class_name Level
extends Node2D
var Sock = preload("res://Scripts/LevelComponents/Sock.gd")

export(float) var time_limit : float

var rng = RandomNumberGenerator.new()
var starting_sock_count : int
var sock_count : int
onready var sock_match_audio = $"../Sock_Match_Audio"
onready var texts_container_node = $"../Texts"

func _ready() -> void:
	rng.randomize()

func collect_pair( sock_1, sock_2 ):
	sock_1.queue_free()
	sock_2.queue_free()
	sock_count -= 2

	var n_texts = texts_container_node.get_child_count();
	var rand_text_idx = rng.randi_range(0, n_texts - 1)
	var text_sprite = texts_container_node.get_child(rand_text_idx)
	var avg_position = (sock_1.position + sock_2.position) / 2
	text_sprite.position = avg_position
	text_sprite.self_modulate = __colors[rng.randi_range(0, len(__colors)-1)]
	text_sprite.show()
	
	sock_match_audio.play()
var __colors = [Color.white, Color.red, Color.cyan, Color.blue, Color.green, Color.purple, Color.orange]
