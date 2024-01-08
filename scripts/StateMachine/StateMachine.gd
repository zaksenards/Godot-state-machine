class_name StateMachine
extends Node

@export var categoryCurrent:bool = false
signal beacon(caller:StateMachine, nodeName:String)
var children:Dictionary
var current:Array

enum States
{
	Motion = 0,
	Interaction = 1,
	CameraMotion = 2 # Not implemented
}

func _ready():

	# We'll handle a constant number of States
	# fill(null) helps to prevent 'IndexError' when trying to 
	# set a state on a specific position of array
	current.resize(States.size())
	current.fill(null)

	for child in get_children():
		if!(child is StateMachine):
			print_debug("Node %s doesn\'t extends StateMachine")
			continue
		
		# Connect the state's signal to a function that handles state transition
		child.beacon.connect(state_transition)
		children[child.name] = child
		if(child.categoryCurrent):
			current[child.get_type()] = child
	
	for _current in current:
		if(!_current):
			continue
		_current.enter()

func get_type() -> int:
	return -1

func enter():
	pass

func input(event):
	for _current in current:
		if(!_current):
			continue
		_current.input(event)

func update():
	for _current in current:
		if(!_current):
			continue
		_current.update()

func exit():
	pass

func state_transition(caller:StateMachine, noneName:String):
	if(!caller || !(caller in current)):
		return
	
	var node = children[noneName]
	if(!node):
		return
	
	var _current = current[node.get_type()]
	_current.exit()
	node.enter()
	current[node.get_type()] = node
