class_name ActivableByObjectComponent extends Node

@export var is_activated: bool = false
@export var area: Area3D

var _bodies_on_button: int = 0

signal status_changed(bool)

func _ready() -> void:
	if area == null:
		printerr("BeActivatedComponent: No Area3D set! Set it in the inspector.")
		return

func _physics_process(_delta: float) -> void:
	var count = area.get_overlapping_bodies().size()
	
	if count > 0 and not is_activated:
		is_activated = true
		status_changed.emit(is_activated)
	elif count == 0 and is_activated:
		is_activated = false
		status_changed.emit(is_activated)
	
	_bodies_on_button = count
