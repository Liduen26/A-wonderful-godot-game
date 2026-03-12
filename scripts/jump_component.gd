class_name JumpComponent extends Node

@onready var body: PhysicsBody3D = $".."
@export var cooldown: float = 0.6
@export var vertical_velocity := 5.0

func update(wants_to_jump: bool) -> void:
	# Jump
	if wants_to_jump and body.is_on_floor() :
		body.velocity.y = vertical_velocity
	
	# TODO : Add cooldown back
