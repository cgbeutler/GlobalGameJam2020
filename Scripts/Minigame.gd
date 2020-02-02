extends Node2D

onready var anim = $AnimationPlayer

onready var timer_label = $UI/Timer
onready var sock_count_label = $UI/SockCount

onready var cursor = $Cursor

onready var levels = [
	load("res://Scripts/Levels/Level1.tscn"),
	load("res://Scripts/Levels/Level2.tscn"),
	load("res://Scripts/Levels/Level3.tscn"),
	load("res://Scripts/Levels/Level4.tscn"),
	load("res://Scripts/Levels/Level5.tscn"),
	load("res://Scripts/Levels/Level6.tscn"),
	load("res://Scripts/Levels/Level99.tscn")
]

var __current_level : int = 0
var __loaded_level
var __timer := Timer.new()

func _ready() -> void:
	__timer.connect("timeout", self, "on_timeout")
	add_child(__timer)
	
	start_level()

func start_level():
	$ReadyGo.hide()
	$FasterFaster.hide()
	$YouWin.hide()
	
	if __loaded_level:  __loaded_level.queue_free()
	__loaded_level = levels[__current_level].instance()
	add_child(__loaded_level)
	
	__timer.start( __loaded_level.time_limit )
	__timer.paused = true
	cursor.can_grab = false
	anim.play("ReadyGo")

func on_ready_anim_done():
	__timer.paused = false
	cursor.can_grab = true

func on_win():
	__timer.paused = true
	anim.play("YouWin")

func on_you_win_anim_done():
	$YouWin/CPUParticles2D.restart()
	__current_level += 1
	if __current_level >= len(levels): __current_level -=1
	start_level()

func on_timeout():
	__timer.stop()
	cursor.can_grab = false
	
	if __current_level == len(levels) - 1:
		if __attempt == 0:
			var music_ctrl = get_node("/root/Background_Music_Ctrl")
			music_ctrl.Start_Transition_Music()
			__attempt += 1
			anim.play("YouLoose")
		else:
			__loaded_level.play_ending()
	else:
		anim.play("YouLoose")
var __attempt = 0

func on_ending_anim_done():
	get_tree().change_scene("res://transition.tscn")

func _process(_delta: float) -> void:
	if __loaded_level:
		# Update Timer
		timer_label.set_seconds( __timer.time_left )
		# Update Sock Count
		sock_count_label.set_sock_count( __loaded_level.sock_count )
		
		if __loaded_level.sock_count == 0:
			on_win()
