class_name StateMotionIdle
extends StateMachine

func is_running() -> int:
	return false


func get_type() -> int:
	return States.Motion

func enter():
	print_debug("Entering Idle state")

func update():
	var direction:Vector2 = Input.get_vector("move_leftward", "move_rightward", "move_forward", "move_backward")
	if(direction.length() > 0):
		beacon.emit(self, "StateMotionWalk")

func exit():
	pass
