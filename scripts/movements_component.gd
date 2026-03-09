class_name MovementsComponents extends Node

@export var body: CharacterBody3D
@export var model: Node3D
@export var speed := 5.0
@export var speed_running_addition := 3.0
@export var jump_velocity := 12.0
@export var gravity_multiplier := 5.0

func _ready() -> void:
	if body == null:
		printerr("No body set! Set it in the inspector of MovementsComponent")
		return

func tick(delta: float, direction := Vector2.ZERO, wants_to_jump := false, wants_to_run := false) -> void:
	# Calcs
	var mov_dir = (body.transform.basis * Vector3(direction.x, 0, direction.y)).normalized()
	var run := 0.0
	
	# Run
	if wants_to_run:
		run = speed_running_addition	
	
	# Movements
	body.velocity.x = mov_dir.x * (speed + run)
	body.velocity.z = mov_dir.z * (speed + run)
	
	# Gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	# Jump
	if wants_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	wants_to_jump = false # reset to avoid jumping multiple times
	
	# Activate movements by velocity
	body.move_and_slide()
