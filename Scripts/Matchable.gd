class_name Matchable
extends Grabbable

export(int) var match_id_override := -1
var match_id := 0

onready var level = $"../"

# Called by cursor when a sock is dropped
func _on_release():
	._on_release()
	var areas = get_overlapping_areas()
	for area in areas:
		var other_match_id = area.get( "match_id" )
		if other_match_id == null:  continue
		if ( match_id == other_match_id or
				match_id %2 == 0 and match_id == other_match_id - 1 or
				match_id %2 == 1 and match_id == other_match_id + 1 ):
			level.collect_pair(self, area)

# Called by cursor when a sock is grabbed
func _on_grab():
	._on_grab()

func _ready() -> void:
	level.sock_count += 1
	if match_id_override >= 0:  match_id = match_id_override
	else:  match_id = level.sock_count - 1
