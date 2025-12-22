extends Node2D

func _on_color_rect_mouse_entered() -> void:
	Utils.mouse_on_map = true

func _on_color_rect_mouse_exited() -> void:
	Utils.mouse_on_map = false
