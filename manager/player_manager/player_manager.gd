extends Resource
class_name PlayerManager

# ======================================== export function
@export var _max_hp := 10
@export var _current_hp := _max_hp
@export var actions :Array[Action] = [
	load("res://data/actions/slash.tres"),
	load("res://data/actions/defend.tres")
]

static func get_actions():
	return _get_instance().actions

static func get_attack():
	return 5

static func get_defense():
	return 5

# ======================================== setter/getter
static var max_hp: int:
	get:
		return _get_instance()._max_hp
	set(value):
		_get_instance()._max_hp = value

static var current_hp: int:
	get:
		return _get_instance()._current_hp
	set(value):
		_get_instance()._current_hp = value

# ======================================== helper
static func _get_instance() -> PlayerManager:
	return GameData.save_game.player_manager
