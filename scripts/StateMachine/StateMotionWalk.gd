class_name StateMotionWalk
extends StateMachine

var body:CharacterBody3D
@export_category("Motion settings")
@export var currentSpeed:float = 0
@export var targetSpeeed:float = 0
@export var sprintSpeed:float = 9
@export var crunchSpeed:float = 1.5
@export var walkSpeed:float = 5

func is_running() -> int:
	return currentSpeed == sprintSpeed;

func get_type() -> int:
	return States.Motion

func enter():
	body = get_parent().get_parent()
	print_debug("Entering Walk state")

func update():
	var direction:Vector2 = Input.get_vector("move_leftward", "move_rightward", "move_forward", "move_backward")
	if(direction.length() == 0):
		beacon.emit(self, "StateMotionIdle")
	
	currentSpeed = walkSpeed
	if(Input.is_action_pressed("move_sprint")):
		currentSpeed = sprintSpeed
	if(Input.is_action_pressed("move_crunch")):
		currentSpeed = crunchSpeed

	var motion:Vector3 = Vector3(direction.x, 0, direction.y) * currentSpeed * body.transform.basis.inverse()
	body.velocity = motion
	body.move_and_slide()

func exit():
	pass
