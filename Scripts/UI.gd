extends CanvasLayer

onready var timer_label = $Content/Timer/Timer
onready var socks_left_label = $Content/SocksLeft/SocksLeft/SockCount

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
	timer_label.set_seconds(__timer.time_left)
