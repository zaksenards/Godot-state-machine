extends CharacterBody3D

@onready var default_collider:CollisionShape3D = $defaultCollider
@onready var crunch_collider:CollisionShape3D = $crunchCollider
@onready var state_machine = $StateMachine
@onready var default_spot = $defaultSpot
@onready var crunch_spot = $crunchSpot
@onready var camera = $camera

func _ready():
	pass

func _physics_process(delta):
	state_machine.update()
	crunch(Input.is_action_pressed("move_crunch"))

func _input(event):
	state_machine.input(event)

func crunch(state:bool):
	if(state):
		camera.position.y = crunch_spot.global_position.y
		default_collider.disabled = true
		crunch_collider.disabled = false
	else:
		camera.position.y = default_spot.global_position.y
		default_collider.disabled = false
		crunch_collider.disabled = true
