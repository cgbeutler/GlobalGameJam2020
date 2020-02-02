extends Node

var tween

onready var minigame_music = $Minigame_Music
onready var transition_music = $Transition_Music

func _ready():
	tween = Tween.new()
	add_child(tween)

func fade_out(stream_player):
	tween.interpolate_property(stream_player, "volume_db", 0, -80, 6, Tween.TRANS_CUBIC, Tween.EASE_IN, 0)
	tween.start()

func fade_in(stream_player):
	tween.interpolate_property(stream_player, "volume_db", -80, 0, 4, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween.start()

func Start_Transition_Music():
	fade_out(minigame_music)
	transition_music.play()
	transition_music.volume_db = -80
	fade_in(transition_music)
