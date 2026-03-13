class_name InteractComponent extends Node

@onready var player: Player = $".."

@export var interaction_ray: RayCast3D

var interacting: bool

func _ready() -> void:
	if interaction_ray == null:
		printerr("No interaction_ray set! Set it in the inspector of " + str(self))
		return

func consume() -> void:
	if not interaction_ray.is_colliding():
		return
	
	var interactible_comp: InteractibleComponent = _find_interactible( interaction_ray.get_collider() )
	if interactible_comp:
		interactible_comp.interact(player)



func _find_interactible(node: Node) -> Node:
	while node != null:
		for child in node.get_children():
			if child is InteractibleComponent:
				return child
		node = node.get_parent()
	return null
