extends Area2D

export(int) var sock_type := 0

# Called by cursor when a sock is dropped
func drop():
	var areas = get_overlapping_areas()
	for area in areas:
		if area.get( "sock_type" ) == sock_type:
			$"..".collect_pair(self, area)
