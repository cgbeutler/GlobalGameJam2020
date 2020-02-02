class_name Grabbable
extends Area2D

var is_grabbed = false
var old_mouse_position = Vector2()
var maxRot = 30
var rotVelocity = 3

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

func _on_grab():
	is_grabbed = true

func _on_release():
	is_grabbed = false
