extends Resource
class_name ExplorationManager

const CELL_SIZE := Vector2(16,16)

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

static func pos_to_cell(pos: Vector2) -> Vector2i:
	return Vector2i((pos / CELL_SIZE).floor())

static func cell_to_pos(cell: Vector2i) -> Vector2:
	return Vector2(cell) * CELL_SIZE

static func cell_to_pos_center(cell: Vector2i) -> Vector2:
	return cell_to_pos(cell) + CELL_SIZE / 2.0
