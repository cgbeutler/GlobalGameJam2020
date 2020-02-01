extends Grabbable

var sock_id := 0
var old_mouse_position = Vector2()
var is_grabbed = false
var maxRot = 30
var rotVelocity = 3

onready var sock_pile = $"../"

func _process( _delta : float ) -> void:
	if is_grabbed:
		calculateDragRotation()

func calculateDragRotation() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	var mouse_delta = mouse_position - old_mouse_position

	if mouse_delta.x > 1.5:
		if rotation_degrees < maxRot: rotation_degrees += rotVelocity
	elif mouse_delta.x < -1.5:
		if rotation_degrees > -maxRot: rotation_degrees -= rotVelocity
	elif mouse_delta.x < 1 && mouse_delta.x > -1:
		if rotation_degrees < 0: rotation_degrees += rotVelocity
		if rotation_degrees > 0: rotation_degrees -= rotVelocity
	old_mouse_position = mouse_position

# Called by cursor when a sock is dropped
func _on_release():
	is_grabbed = false
	var areas = get_overlapping_areas()
	for area in areas:
		var other_sock_id = area.get( "sock_id" )
		if other_sock_id == null:  continue
		if ( sock_id == other_sock_id or
				sock_id %2 == 0 and sock_id == other_sock_id - 1 or
				sock_id %2 == 1 and sock_id == other_sock_id + 1 ):
			sock_pile.collect_pair(self, area)

# Called by cursor when a sock is grabbed
func _on_grab():
	is_grabbed = true

func _ready() -> void:
	sock_id = sock_pile.claim_sock_id()
	$Sprite.frame = sock_id
