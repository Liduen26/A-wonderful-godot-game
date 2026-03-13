class_name PlayerInputsComponent extends Node

var mouse_captured := false
var look_dir := Vector2.ZERO

signal interact

func get_horizontal_mov_dir() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
func is_run_pressed() -> bool:
	return Input.is_action_pressed("run")
	
func is_jump_pressed() -> bool:
	return Input.is_action_pressed("jump")


func get_mouse_mov_dir() -> Vector2:
	var look_dir_to_return := look_dir
	look_dir = Vector2.ZERO
	return look_dir_to_return
	
# For inputs NOT in Godot's keybind mapping
func _unhandled_input(event: InputEvent) -> void:
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_capture_mouse()
	# Uncapture when escape to allow exiting the window
	if Input.is_key_pressed(KEY_ESCAPE):
		_release_mouse()
	
	# Look around
	if mouse_captured and event is InputEventMouseMotion:
		look_dir = event.relative
	
	if Input.is_action_just_pressed("action"):
		interact.emit()


func _capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func _release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
