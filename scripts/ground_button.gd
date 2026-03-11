extends Node3D

@onready var be_activated_by_object_component: BeActivatedByObjectComponent = %BeActivatedByObjectComponent
@onready var press_component: PressComponent = %PressComponent
@onready var sfx_click = $sfx_click

func _ready() -> void:
	be_activated_by_object_component.status_changed.connect(update_status)

func update_status(new_status: bool) -> void:
	press_component.activated = new_status
	sfx_click.play()
	pass
