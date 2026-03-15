class_name PickupableComponent extends Node

@export var interactible_component: InteractibleComponent

@export var is_held: bool = false
@onready var pickupable_object: RigidBody3D = $".."
@export var hold_distance: float = 2.0
@export var hold_height_offset: float = -0.3

var _saved_collision_layer: int
var _saved_collision_mask: int
var _player: Player



func _ready() -> void:
	if pickupable_object == null:
		printerr("No RigidBody3D as parent of " + str(self))
	pickupable_object.collision_layer = 3
	_saved_collision_layer = pickupable_object.collision_layer
	_saved_collision_mask = pickupable_object.collision_mask
	
	if interactible_component == null:
		printerr("No InteractibleComponent set ! Set it in the inspector of " + str(self))
	interactible_component.interacted.connect(_grab)

func _grab(player: Player) -> void:
	set_is_held(!is_held, player)

func set_is_held(new_status: bool, player: Player) -> void:
	is_held = new_status
	if is_held:
		_pick_up()
		_player = player
	else:
		_drop()
		_player = null
		

func _pick_up() -> void:
	pickupable_object.freeze = false
	pickupable_object.gravity_scale = 0.0
	pickupable_object.linear_velocity = Vector3.ZERO
	pickupable_object.angular_velocity = Vector3.ZERO
	pickupable_object.collision_layer = 3
	pickupable_object.collision_mask = 1

func _drop() -> void:
	pickupable_object.gravity_scale = 1.0
	pickupable_object.collision_layer = _saved_collision_layer
	pickupable_object.collision_mask = _saved_collision_mask


func _find_camera(node: Node) -> Node:
	while node != null:
		for child in node.get_children():
			if child is Camera3D:
				return child
		node = node.get_parent()
	return null


func _physics_process(_delta: float) -> void:
	if not is_held or not _player or not _player.camera:
		return
	
	var forward = -_player.camera.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var target_pos = _player.camera.global_position + forward * hold_distance
	target_pos.y = _player.camera.global_position.y + hold_height_offset

	var direction = (target_pos - pickupable_object.global_position)
	if direction.length() > 0.1:
		pickupable_object.linear_velocity = direction * 15.0
	else:
		pickupable_object.linear_velocity = Vector3.ZERO

	pickupable_object.angular_velocity = Vector3.ZERO
