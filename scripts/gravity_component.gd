class_name GravityComponent extends Node

@onready var body: PhysicsBody3D = $".."

@export var gravity_multiplier := 1.6

func update(delta: float) -> void:
	# Gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	body.move_and_slide()
