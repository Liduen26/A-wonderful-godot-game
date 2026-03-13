class_name Player extends CharacterBody3D

@onready var player_inputs_component: PlayerInputsComponent = %PlayerInputsComponent
@onready var movements_components: MovementsComponents = %MovementsComponents
@onready var look_around_component: LookAroundComponent = %LookAroundComponent
@onready var gravity_component: GravityComponent = %GravityComponent
@onready var jump_component: JumpComponent = %JumpComponent
@onready var interact_component: InteractComponent = %InteractComponent
@onready var camera: Camera3D = $Head/Camera

func _ready() -> void:
	player_inputs_component.interact.connect(_player_interact)

func _physics_process(delta: float) -> void:
	jump_component.update(player_inputs_component.is_jump_pressed())
	look_around_component.update(player_inputs_component.get_mouse_mov_dir())	
	movements_components.update(
		player_inputs_component.get_horizontal_mov_dir(), 
		player_inputs_component.is_run_pressed()
	)
	
	gravity_component.update(delta)	

func _player_interact() -> void:
	interact_component.consume()
