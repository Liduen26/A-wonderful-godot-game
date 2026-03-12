class_name Player extends CharacterBody3D

@onready var player_inputs_component: PlayerInputsComponent = %PlayerInputsComponent
@onready var movements_components: MovementsComponents = %MovementsComponents
@onready var look_around_component: LookAroundComponent = %LookAroundComponent
@onready var gravity_component: GravityComponent = %GravityComponent
@onready var jump_component: JumpComponent = %JumpComponent


func _physics_process(delta: float) -> void:
	jump_component.update(player_inputs_component.get_jump_input())
	look_around_component.update(player_inputs_component.get_mouse_input())	
	movements_components.update(
		player_inputs_component.get_horizontal_mov_inputs(), 
		player_inputs_component.get_run_input()
	)
	gravity_component.update(delta)
	
