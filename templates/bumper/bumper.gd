@tool
extends StaticBody2D
class_name Bumper

signal bumped
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _init() -> void:
	collision_layer = 1 << 2 # Layer 3
	collision_mask = 0      # Keine Mask

func bump() -> void:
	bumped.emit()

func set_enabled(enabled: bool) -> void:
	if collision_shape == null: return
	visible = enabled
	collision_shape.set_deferred("disabled", !enabled)
