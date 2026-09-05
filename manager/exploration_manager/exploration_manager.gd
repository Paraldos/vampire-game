extends Resource
class_name ExplorationManager

const TILE_SIZE := Vector2(16,16)

# ======================================== set / get
static var current_level : PackedScene:
	get:
		return Utils.game_data.current_level
	set(value):
		Utils.game_data.current_level = value

static var respawn_level : PackedScene:
	get:
		return Utils.game_data.respawn_level
	set(value):
		Utils.game_data.respawn_level = value

static var flags : Array[Flag]:
	get:
		return Utils.game_data.flags
	set(value):
		Utils.game_data.flags = value

# ======================================== start / stop
static func change_level(new_level: PackedScene, new_spawn_point := 0) -> void:
	current_level = new_level
	SceneManager.change_scene(current_level)
	await SceneManager.halfpoint
	GlobalSignals.trigger_spawn_point.emit(new_spawn_point)

static func respawn():
	current_level = respawn_level
	SceneManager.change_scene(current_level)
	await SceneManager.halfpoint
	GlobalSignals.trigger_spawn_point.emit(-1)

static func get_tile_pos(pos: Vector2) -> Vector2:
	return pos.snapped(TILE_SIZE)

static func get_tile_center_pos(pos: Vector2) -> Vector2:
	return pos.snapped(TILE_SIZE) - TILE_SIZE / 2
