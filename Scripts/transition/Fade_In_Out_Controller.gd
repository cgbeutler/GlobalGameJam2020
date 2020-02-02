extends MeshInstance

var fade_in = true
var fade_out = false 

var time = 0

func _process(delta):
	time += delta
	if time > 10:
		fade_out = true
		show()

	if fade_in && time > 2:
		fadeIn(time)
	elif fade_out:
		fadeOut(time)

func fadeOut(time):
	var mat = get_surface_material(0)
	if mat.albedo_color.a >= 1:
		fade_out = false
		get_tree().change_scene("res://Transition2.tscn")
	else:
		mat.albedo_color.a += 0.01
		set_surface_material(0, mat)

func fadeIn(time):
	var mat = get_surface_material(0)
	if mat.albedo_color.a <= 0:
		fade_in = false
		hide()
	else:
		mat.albedo_color.a -= 0.01
		set_surface_material(0, mat)
