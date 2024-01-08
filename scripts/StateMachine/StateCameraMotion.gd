class_name StateCameraMotion
extends StateMachine

var body:CharacterBody3D

func get_type() -> int:
	return States.CameraMotion

func enter():
	print_debug("Entering Camera motion Idle state")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	body = get_parent().get_parent()

func update():
	pass

func input(event):
	if event is InputEventMouseMotion:
		body.rotate_y(-(event.relative.x*1e-3))

func exit():
	pass
