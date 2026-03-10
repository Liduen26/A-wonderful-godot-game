class_name StayPressedComponent extends Node

@export var visualFeedbackNode: Node3D
@export var activatorNode: Node3D
@export var activated := false
@export var movement_direction := Vector3(0.0, -1.0, 0.0)
@export var movement_speed := 5.0

var initialPos := Vector3.ZERO


func _ready() -> void:
	if visualFeedbackNode == null:
		printerr("No visualFeedbackNode set! Set it in the inspector of " + str(self))
		return
	
	initialPos = visualFeedbackNode.transform.origin
	

func _process(delta: float) -> void:
	var mov_vector: Vector3 = movement_direction * movement_speed * delta
	if activated:
		visualFeedbackNode.translate(mov_vector)
	else:
		#if not top_reached(visualFeedbackNode):
		visualFeedbackNode.translate(-mov_vector)
		
	
func top_reached(visualFeedbackNode: Node3D) -> bool:
	return visualFeedbackNode.get_poi 
	return false
	

#func is_touching_activator() -> bool:
	#return 
