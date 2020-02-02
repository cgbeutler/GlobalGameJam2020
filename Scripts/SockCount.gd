extends MarginContainer

onready var sock_count_label := $Control/VBox/SockCount

func set_sock_count( count : int ):
	sock_count_label.text = str(count)
