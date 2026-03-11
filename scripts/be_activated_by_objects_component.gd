class_name BeActivatedByObjectComponent extends Node

@export var activable_mesh: Node3D
@export var is_activated: bool = false
var _bodies_on_button: int = 0
@export var area: Area3D

signal status_changed(bool)

func _ready() -> void:
	if activable_mesh == null:
		printerr("BeActivatedComponent: No activable_mesh set! Set it in the inspector.")
		return
	
	var existing_shape = activable_mesh.get_node_or_null("StaticBody3D/CollisionShape3D")
	if existing_shape == null:
		printerr("BeActivatedComponent: No CollisionShape3D found in activable_mesh!")
		return

	if area == null:
		printerr("BeActivatedComponent: No activable_mesh set! Set it in the inspector.")
		return

func _physics_process(_delta: float) -> void:
	var count = area.get_overlapping_bodies().size()
	
	if count > 0 and not is_activated:
		is_activated = true
		status_changed.emit(is_activated)
		print("Button activated!")
	elif count == 0 and is_activated:
		is_activated = false
		status_changed.emit(is_activated)
		print("Button deactivated!")
	
	_bodies_on_button = count
