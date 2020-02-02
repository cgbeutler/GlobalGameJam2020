extends CanvasLayer

onready var timer_label = $Content/Timer/Timer
onready var socks_left_label = $"Content/Socks Left/Socks Left/SockCount"
onready var ready_go

var __timer : Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Show ready go anim. Continued from callback
	_on_ready_go_anim_complete()
	pass # Replace with function body.

func _on_ready_go_anim_complete():
	add_child(__timer)
	__timer.start(70)
	print("t: T", __timer.is_stopped())

func _process(delta: float) -> void:
	var minutes = int(floor(__timer.time_left / 60.0))
	var minutes_text = "%d:" % minutes if minutes else ""
	var seconds_text = "%02d." % floor(fmod(__timer.time_left, 60))
	var milliseconds_text = ("%.2f" % fmod(__timer.time_left, 1)).split(".")[1]
	
	timer_label.text = minutes_text + seconds_text + milliseconds_text
