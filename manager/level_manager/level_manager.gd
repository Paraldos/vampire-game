extends Resource
class_name LevelManager

const TILE_SIZE := Vector2(16,16)

# ======================================== set / get
static var current_level : PackedScene:
	get:
		return GameData.save_game.current_level
	set(value):
		GameData.save_game.current_level = value

static var start_point : int:
	get:
		return GameData.save_game.start_point
	set(value):
		GameData.save_game.start_point = value

# ======================================== start / stop
func change_level(new_level: PackedScene, new_start_point := 0) -> void:
	current_level = new_level
	start_point = new_start_point
	SceneManager.change_scene(current_level)

func reload_level():
	SceneManager.change_scene(current_level)

static func get_tile_pos(pos: Vector2) -> Vector2:
	return pos.snapped(LevelManager.TILE_SIZE)

static func get_tile_center_pos(pos: Vector2) -> Vector2:
	return pos.snapped(LevelManager.TILE_SIZE) - LevelManager.TILE_SIZE / 2
