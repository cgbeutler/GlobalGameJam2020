extends Area2D

export(bool) var can_grab := true

var grabbed_obj : Grabbable
var grabbed_obj_offset

var open_hand_sprite : Sprite
var closed_hand_sprite : Sprite

func _ready():
	open_hand_sprite = get_node("Open_Hand_Sprite")
	closed_hand_sprite = get_node("Closed_Hand_Sprite")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func __grab_topmost():
	var areas = get_overlapping_areas()
	grabbed_obj = null
	for area in areas:
		if area is Grabbable:
			if not grabbed_obj:  grabbed_obj = area
			else:
				if area.get_index() > grabbed_obj.get_index():
					grabbed_obj = area
	
	if grabbed_obj:
		grabbed_obj_offset = grabbed_obj.position - position
		grabbed_obj.z_index = 1
		grabbed_obj._on_grab()

func __release():
	if not grabbed_obj:  return
	grabbed_obj.z_index = 0
	grabbed_obj._on_release()
	grabbed_obj = null
	


func _process( _delta : float ) -> void:
	# Move self to the mouse's position
	position = get_viewport().get_mouse_position()
	# Move sock relative to cursor
	if grabbed_obj:  grabbed_obj.position = position + grabbed_obj_offset

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			open_hand_sprite.hide()
			closed_hand_sprite.show()
			__grab_topmost()
		else:
			open_hand_sprite.show()
			closed_hand_sprite.hide()
			__release()

