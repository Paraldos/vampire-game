extends Resource
class_name LevelManager

const TILE_SIZE := Vector2(16,16)

@export_storage var level : PackedScene = load("uid://h6t750kmppjs")
@export_storage var start_point := 0

func change_level(new_level: PackedScene, new_start_point := 0) -> void:
	level = new_level
	start_point = new_start_point
	SceneManager.change_scene(level)

func reload_level():
	SceneManager.change_scene(level)

static func get_tile_pos(pos: Vector2) -> Vector2:
	return pos.snapped(LevelManager.TILE_SIZE)

static func get_tile_center_pos(pos: Vector2) -> Vector2:
	return pos.snapped(LevelManager.TILE_SIZE) - LevelManager.TILE_SIZE / 2
