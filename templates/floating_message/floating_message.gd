extends Node2D

@onready var label: Label = %Label
@export_multiline var text := "":
	set(value):
		text = value
		if is_node_ready():
			_update_label()

func _ready() -> void:
	_update_label()

func _update_label() -> void:
	label.text = text

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
