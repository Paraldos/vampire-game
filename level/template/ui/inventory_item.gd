extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed('ui_left_click'):
		print('click')
