class_name Cube extends RigidBody3D
@onready var interactible_component: InteractibleComponent = $InteractibleToggleComponent
@onready var pickupable_component: PickupableComponent = %PickupableComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactible_component.interacted.connect(_grab)

func _grab(player: Player) -> void:
	pickupable_component.set_is_held(!pickupable_component.is_held, player)
