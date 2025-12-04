extends RayCast2D

@export var point_number = 0
var player_bp = preload("res://player/player.tscn")

func _ready() -> void:
	SignalController.spawn_player.connect(_on_spawn_player)

func _on_spawn_player(target_point):
	if target_point != point_number: return
	var player = player_bp.instantiate()
	player.global_position = global_position
	get_tree().current_scene.add_child(player)
