class_name PressComponent extends Node

@export var visual_feedback_node: Node3D
@export var activated := false
@export var pressed_position := Vector3(0.0, -1.0, 0.0)
@export var movement_speed := 6.0

signal output_active(bool)

var initial_pos := Vector3.ZERO
var movement_direction := Vector3.ZERO

func _ready() -> void:
	if visual_feedback_node == null:
		printerr("No visual_feedback_node set! Set it in the inspector of " + str(self))
		return
	
	initial_pos = visual_feedback_node.transform.origin
	movement_direction = (pressed_position - initial_pos).normalized()

func _process(delta: float) -> void:
	var mov_vector: Vector3 = movement_direction * movement_speed * delta
	if activated:
		if pressed_pos_reached():
			output_active.emit(true)
		else:
			visual_feedback_node.translate(mov_vector)
	else:
		output_active.emit(false)
		if not initial_pos_reached():
			visual_feedback_node.translate(-mov_vector)


func initial_pos_reached() -> bool:
	return abs(visual_feedback_node.transform.origin) >= abs(initial_pos)
	
func pressed_pos_reached() -> bool:
	return abs(visual_feedback_node.transform.origin) <= abs(pressed_position)
