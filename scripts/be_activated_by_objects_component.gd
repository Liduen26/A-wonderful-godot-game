class_name BeActivatedByObjectComponent extends Node

@export var activable_mesh: Node3D
@export var is_activated: bool = false
var _bodies_on_button: int = 0
var _area: Area3D

func _ready() -> void:
	if activable_mesh == null:
		printerr("BeActivatedComponent: No activable_mesh set! Set it in the inspector.")
		return
	
	var existing_shape = activable_mesh.get_node_or_null("StaticBody3D/CollisionShape3D")
	if existing_shape == null:
		printerr("BeActivatedComponent: No CollisionShape3D found in activable_mesh!")
		return

	_area = Area3D.new()
	_area.collision_layer = 0
	_area.collision_mask = 4  # layer 3 (pickable)
	_area.monitoring = true
	_area.monitorable = false
	
	var shape = CollisionShape3D.new()
	shape.shape = existing_shape.shape
	_area.add_child(shape)
	activable_mesh.add_child(_area)

func _physics_process(_delta: float) -> void:
	if _area == null:
		return
	
	var count = _area.get_overlapping_bodies().size()
	
	if count > 0 and not is_activated:
		is_activated = true
		print("Button activated!")
	elif count == 0 and is_activated:
		is_activated = false
		print("Button deactivated!")
	
	_bodies_on_button = count
