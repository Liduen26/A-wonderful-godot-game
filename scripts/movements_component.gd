class_name MovementsComponents extends Node

@onready var body: PhysicsBody3D = $".."

@export var model: Node3D
@export var speed := 3.0
@export var speed_running_addition := 2.0

var cooldown := 0.0
var mov_dir: Vector3 

func _ready() -> void:
	if body == null:
		printerr("No body set! Set it in the inspector of " + str(self))
		return

func update(horizontal_direction := Vector2.ZERO, wants_to_run := false) -> void:
	# Calcs
	var run := 0.0
	var air_dir := Vector3.ZERO
	
	if body.is_on_floor():
		mov_dir = (body.transform.basis * Vector3(horizontal_direction.x, 0, horizontal_direction.y)).normalized()
	else:
		# air control
		air_dir = (body.transform.basis * Vector3(horizontal_direction.x, 0, horizontal_direction.y)).normalized() 
	
	# Run
	if wants_to_run:
		run = speed_running_addition	
	
	# Movements
	body.velocity.x = mov_dir.x * (speed + run)
	body.velocity.z = mov_dir.z * (speed + run)
	body.velocity += air_dir
	
	# Activate movements by velocity
	body.move_and_slide()
