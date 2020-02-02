extends Grabbable

var sock_id := 0

onready var level = $"../"

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
			level.collect_pair(self, area)

# Called by cursor when a sock is grabbed
func _on_grab():
	is_grabbed = true

func _ready() -> void:
	sock_id = level.claim_sock_id()
	$Sprite.frame = sock_id
