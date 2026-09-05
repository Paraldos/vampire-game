extends "res://levels/interactable.gd"

@onready var spawn_point: Marker2D = %SpawnPoint
@onready var info_label: Node2D = %InfoLabel
@onready var camera: Camera2D = %Camera

const PLAYER = preload("uid://uuu0f4178hm5")
var active = false

func _ready() -> void:
	super()
	info_label.modulate.a = 0.0 if active else 1.0
	GlobalSignals.trigger_spawn_point.connect(_on_trigger_spawn_point)

func _input(event: InputEvent) -> void:
	if !active:
		return
	if event.is_action_pressed("ui_accept"):
		_toggle()
		GlobalSignals.spawn_player.emit(spawn_point.global_position)

func _on_trigger_spawn_point(idx):
	if idx > 0:
		return
	camera.enabled = true
	active = true

func _toggle():
	active = !active
	camera.enabled = active
	if active:
		info_label.fade_in()
	else:
		info_label.fade_out()
