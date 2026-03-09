class_name Player extends CharacterBody3D

@onready var inputs_component: InputsComponent = %InputsComponent
@onready var movements_components: MovementsComponents = %MovementsComponents
@onready var look_around_component: LookAroundComponent = %LookAroundComponent


func _physics_process(delta: float) -> void:
	movements_components.tick(delta, inputs_component.movement_direction, inputs_component.jump_pressed, inputs_component.run_pressed)
	
	look_around_component.tick(delta, inputs_component.look_direction)
	inputs_component.look_direction = Vector2.ZERO
