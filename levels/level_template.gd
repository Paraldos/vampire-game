extends Node2D
# level template

@onready var start_points: Node2D = %StartPoints
@onready var player_container: Node2D = %PlayerContainer

const PLAYER = preload("uid://uuu0f4178hm5")

func _ready() -> void:
	var target_index: int = GameData.level_manager.start_point
	var target_point : Node2D
	if target_index >= 0 and target_index < start_points.get_child_count():
		target_point = start_points.get_child(target_index)
	else:
		target_point = start_points.get_child(0)
	var target_pos := LevelManager.get_tile_center_pos(target_point.global_position)
	_spawn_player(target_pos)

func _spawn_player(pos):
	var p = PLAYER.instantiate()
	p.global_position = pos
	player_container.add_child(p)
