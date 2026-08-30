extends Resource
class_name PlayerManager

# ======================================== export function
@export var _hero_formation: Array[Hero] = [
	load("res://data/heros/test_hero.tres"),
	null,
	null,
	null,
]

# ======================================== setter/getter
static var hero_formation: Array[Hero]:
	get:
		return _get_instance()._hero_formation
	set(value):
		_get_instance()._hero_formation = value

# ======================================== helper
static func _get_instance() -> PlayerManager:
	return GameData.save_game.player_manager
