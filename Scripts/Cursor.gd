extends Area2D
var Sock = preload("Sock.gd")


var sock
var sock_offset


func __grab_topmost_sock():
	var areas = get_overlapping_areas()
	sock = null
	for area in areas:
		if area is Sock:
			if not sock:  sock = area
			else:
				if area.get_index() > sock.get_index():
					sock = area
	
	if sock:
		sock_offset = sock.position - position
		sock.z_index = 1

func __release_sock():
	if not sock:  return
	sock.z_index = 0
	sock.drop()
	sock = null


func _process( _delta : float ) -> void:
	# Move self to the mouse's position
	position = get_viewport().get_mouse_position()
	# Move sock relative to cursor
	if sock:  sock.position = position + sock_offset

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			__grab_topmost_sock()
		else:
			__release_sock()

