@tool
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

func fade_in():
	_fade_animation(0.0, 1.0)

func fade_out():
	_fade_animation(1.0, 0.0)

func _fade_animation(start_value := 0.0, end_value := 1.0):
	var t = create_tween()
	modulate.a = start_value
	t.tween_property(self, "modulate:a", end_value, 0.3)
