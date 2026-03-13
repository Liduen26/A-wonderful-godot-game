extends Node3D

@onready var activable_by_object_component: ActivableByObjectComponent = %ActivableByObjectComponent
@onready var press_component: PressComponent = %PressComponent
@onready var sfx_click = $sfx_click

var lights: Array[Light3D]

func _ready() -> void:
	activable_by_object_component.status_changed.connect(update_status)
	press_component.output_active.connect(button_activated_state_change)

	for subnode in get_children(true):
		if subnode is Light3D:
			lights.push_front(subnode)
			subnode.light_color = Color(Color.BLUE)
			

func update_status(new_status: bool) -> void:
	press_component.activated = new_status
	sfx_click.play()
	pass

func button_activated_state_change(new_status: bool) -> void:
	if lights.size() > 0:
		for light_source in lights:
			light_source.light_color = Color(Color.GOLDENROD) if new_status else Color(Color.BLUE)
