extends Resource
class_name PlayerManager

# ======================================== export function
@export var _max_hp := 30
@export var _current_hp := _max_hp
@export var actions :Array[Action] = [
	load("res://data/actions/slash.tres"),
	load("res://data/actions/defend.tres")
]
@export var _attack := 10
@export var _defense := 5

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

static var attack: int:
	get:
		return _get_instance()._attack
	set(value):
		_get_instance()._attack = value

static var defense: int:
	get:
		return _get_instance()._defense
	set(value):
		_get_instance()._defense = value

# ======================================== helper
static func get_actions():
	return _get_instance().actions

static func _get_instance() -> PlayerManager:
	return GameData.save_game.player_manager
