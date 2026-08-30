extends StaticBody2D
class_name Bumper

signal bumped

func _init() -> void:
	collision_layer = 0
	set_collision_layer_value(1, true)
	set_collision_layer_value(3, true)
	collision_mask = 0

func bump() -> void:
	bumped.emit()
