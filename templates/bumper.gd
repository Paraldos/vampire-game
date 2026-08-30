extends StaticBody2D
class_name Bumper

signal bumped
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _init() -> void:
	collision_layer = 0
	set_collision_layer_value(1, true)
	set_collision_layer_value(3, true)
	collision_mask = 0

func bump() -> void:
	bumped.emit()

func set_enabled(enabled: bool) -> void:
	if collision_shape == null: return
	visible = enabled
	collision_shape.set_deferred("disabled", !enabled)
