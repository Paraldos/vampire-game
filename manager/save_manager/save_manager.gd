extends Node
class_name SaveManager

const SAVE_GAME_PATH := "user://save_%s.tres"
const SAVE_INFO_PATH := "user://save_%s_info.tres"
const START_MAP = preload("uid://c4hx48uxrnfdn")

static func new_game() -> void:
	Utils.game_data = GameData.new()
	SceneManager.change_scene(START_MAP)

static func save_game(slot_number: int = 0) -> Error:
	return ResourceSaver.save(Utils.game_data.save_game, get_save_path(slot_number))

static func load_game(slot_number: int = 0) -> Error:
	if not save_exists(slot_number):
		push_error("Save slot %s does not exist." % slot_number)
		return ERR_FILE_NOT_FOUND
	var save := ResourceLoader.load(
		get_save_path(slot_number),
		"",
		ResourceLoader.CACHE_MODE_IGNORE
	) as GameData
	if save == null:
		push_error("Save slot %s could not be loaded." % slot_number)
		return ERR_FILE_CORRUPT
	Utils.game_data.save_game = save
	return OK

# ================================================== Helper
static func get_save_path(slot_number: int) -> String:
	return SAVE_GAME_PATH % slot_number

static func get_save_info_path(slot_number: int) -> String:
	return SAVE_INFO_PATH % slot_number

static func save_info(info: SaveInfo, slot_number: int) -> Error:
	return ResourceSaver.save(info, get_save_info_path(slot_number))

static func save_exists(slot_number: int) -> bool:
	return ResourceLoader.exists(get_save_path(slot_number))

static func get_current_date() -> String:
	var date := Time.get_datetime_dict_from_system()
	return "%02d.%02d.%04d - %02d:%02d" % [
		date.day,
		date.month,
		date.year,
		date.hour,
		date.minute,
	]
