extends MeshInstance

var fade_in = true
var fade_out = false 

var time = 0

func _process(delta):
	time += delta
	
	if time > 6:
		show()
		fade_out = true
	
	if fade_in:
		var mat = get_surface_material(0)
		if mat.albedo_color.a <= 0:
			fade_in = false
			hide()
		else:
			mat.albedo_color.a -= 0.005
			set_surface_material(0, mat)
	elif fade_out:
		var mat = get_surface_material(0)
		if mat.albedo_color.a >= 1:
			fade_out = false
		else:
			mat.albedo_color.a += 0.008
			set_surface_material(0, mat)
		
