extends MarginContainer

onready var timer_label := $Control/TimerLabel

func set_seconds( secs : float ):
	var minutes = int(floor(secs / 60.0))
	var minutes_text = "%d:" % minutes if minutes else ""
	var seconds_text = "%02d." % floor(fmod(secs, 60))
	var milliseconds_text = ("%.2f" % fmod(secs, 1)).split(".")[1]
	
	timer_label.text = minutes_text + seconds_text + milliseconds_text
