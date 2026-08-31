extends Resource
class_name PlayerManager

# ======================================== export function
@export var _max_hp := 20
@export_storage var _current_hp := _max_hp

@export var _max_armor := 20
@export_storage var _current_armor := _max_armor

@export var _attack := 10

@export var actions :Array[Action] = [
	load("res://data/actions/slash.tres"),
	load("res://data/actions/defend.tres")
]

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

static var max_armor: int:
	get:
		return _get_instance()._max_armor
	set(value):
		_get_instance()._max_armor = value

static var current_armor: int:
	get:
		return _get_instance()._current_armor
	set(value):
		_get_instance()._current_armor = value

static var attack: int:
	get:
		return _get_instance()._attack
	set(value):
		_get_instance()._attack = value

# ======================================== helper
static func deal_damage(amount: int) -> void:
	var remaining_damage := maxi(amount - current_armor, 0)
	current_armor = maxi(current_armor - amount, 0)
	current_hp = maxi(current_hp - remaining_damage, 0)

static func get_actions():
	return _get_instance().actions

static func _get_instance() -> PlayerManager:
	return GameData.save_game.player_manager
