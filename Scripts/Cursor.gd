extends Area2D

export(bool) var can_grab := true setget set_can_grab, get_can_grab
func set_can_grab( value ):
	can_grab = value
	if not grabbed_obj:  return
	grabbed_obj.z_index = initial_z_index
	grabbed_obj = null
func get_can_grab():  return can_grab

var grabbed_obj : Grabbable
var grabbed_obj_offset

onready var open_hand_sprite := $Open_Hand_Sprite
onready var open_hand_animator := $Open_Hand_Sprite/AnimationPlayer
onready var closed_hand_sprite := $Closed_Hand_Sprite
onready var hand_close_audio = $Hand_Close_Audio
onready var hand_open_audio = $Hand_Open_Audio

var initial_z_index

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	open_hand_sprite.show()
	open_hand_animator.get_animation("Sparkle").loop = true
	open_hand_animator.play("Sparkle")
	closed_hand_sprite.hide()

func __grab_topmost():
	var areas = get_overlapping_areas()
	grabbed_obj = null
	for area in areas:
		if area is Grabbable:
			if not grabbed_obj:  grabbed_obj = area
			else:
				if area.z_index > grabbed_obj.z_index:
					grabbed_obj = area
	
	if grabbed_obj:
		grabbed_obj_offset = grabbed_obj.position - position
		initial_z_index = grabbed_obj.z_index
		grabbed_obj.z_index = 9
		grabbed_obj._on_grab()

func __release():
	if not grabbed_obj:  return
	grabbed_obj.z_index = initial_z_index
	grabbed_obj._on_release()
	grabbed_obj = null
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Move self to the mouse's position
		position =  event.position
		# Move sock relative to cursor
		if grabbed_obj:  grabbed_obj.position = position + grabbed_obj_offset
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed and can_grab:
			hand_close_audio.play()
			open_hand_sprite.hide()
			closed_hand_sprite.show()
			__grab_topmost()
		else:
			hand_open_audio.play()
			open_hand_sprite.show()
			closed_hand_sprite.hide()
			__release()

