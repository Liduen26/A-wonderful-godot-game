class_name LookAroundComponent extends Node

@export var body: CharacterBody3D
@export var camera: Camera3D

@export var look_speed = 5.0

var look_rotation: Vector2

func _ready() -> void:
	if body == null:
		printerr("No body set! Set it in the inspector of MovementsComponent")
		return
		
	look_rotation.y = body.rotation.y
	look_rotation.x = camera.rotation.x

func tick(delta: float, look_direction: Vector2) -> void:
	# calcs
	const SPEED_DEMULTIPLIER = 1000
	look_rotation.y -= (look_direction.x * look_speed) / SPEED_DEMULTIPLIER 	# left/right
	look_rotation.x -= (look_direction.y * look_speed) / SPEED_DEMULTIPLIER	# up/down
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85)) # limit up/down
	
	# Reset basis to avoid camera jitteriness
	body.transform.basis = Basis()
	camera.transform.basis = Basis()
	
	# Apply rotation
	body.rotate_y(look_rotation.y)
	camera.rotate_x(look_rotation.x)
