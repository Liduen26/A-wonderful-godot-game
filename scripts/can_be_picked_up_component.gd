class_name CanBePickedUpComponent extends Node

@export var pick_up_distance: float = 3.0
@export var hold_distance: float = 1.8
@export var hold_height_offset: float = -0.3

var _object: RigidBody3D
var _player: CharacterBody3D = null
var _camera: Camera3D = null
var _saved_collision_layer: int
var _saved_collision_mask: int
var is_held: bool = false

func _ready() -> void:
	_object = get_parent()
	_saved_collision_layer = _object.collision_layer
	_saved_collision_mask = _object.collision_mask

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if is_held:
			_drop()
		else:
			_try_pick_up()

func _try_pick_up() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return

	_player = players[0]
	_camera = _player.get_node_or_null("Camera")

	if _camera == null:
		printerr("CanBePickedUpComponent: No Camera found in Player!")
		return

	var space_state = _object.get_world_3d().direct_space_state
	var ray_origin = _camera.global_position
	var ray_target = ray_origin + (-_camera.global_transform.basis.z * pick_up_distance)

	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target)
	query.exclude = [_player.get_rid()]
	query.collision_mask = 4  # layer 3 (pickable)
	var result = space_state.intersect_ray(query)

	if result and result.collider == _object:
		_pick_up()

func _pick_up() -> void:
	is_held = true
	_object.freeze = false
	_object.gravity_scale = 0.0
	_object.linear_velocity = Vector3.ZERO
	_object.angular_velocity = Vector3.ZERO
	_object.collision_layer = 3
	_object.collision_mask = 1

func _drop() -> void:
	is_held = false
	_object.gravity_scale = 1.0
	_object.collision_layer = _saved_collision_layer
	_object.collision_mask = _saved_collision_mask
	_player = null
	_camera = null

func _physics_process(_delta: float) -> void:
	if not is_held or _camera == null:
		return

	var forward = -_camera.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var target_pos = _camera.global_position + forward * hold_distance
	target_pos.y = _camera.global_position.y + hold_height_offset

	var direction = (target_pos - _object.global_position)
	if direction.length() > 0.1:
		_object.linear_velocity = direction * 15.0
	else:
		_object.linear_velocity = Vector3.ZERO

	_object.angular_velocity = Vector3.ZERO
