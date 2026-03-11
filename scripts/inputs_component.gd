class_name InputsComponent extends Node

var movement_direction: Vector2
var jump_pressed: bool
var run_pressed: bool
var look_direction: Vector2
var mouse_captured := false


# For inputs in Godot's keybind mapping
func _input(event: InputEvent) -> void:
	movement_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	jump_pressed = Input.is_action_pressed("jump")
	run_pressed = Input.is_action_pressed("run")


# For inputs NOT in Godot's keybind mapping
func _unhandled_input(event: InputEvent) -> void:
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	# Uncapture when escape to allow exiting the window
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	
	# Look around
	if mouse_captured and event is InputEventMouseMotion:
		look_direction = event.relative
	


func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
