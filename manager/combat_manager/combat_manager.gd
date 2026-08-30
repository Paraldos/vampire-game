extends Resource
class_name CombatManager

const COMBAT_SIZE := 3

@export_storage  var _current_combat: Combat

# ======================================== setter/getter
static var current_combat: Combat:
	get:
		return _get_instance()._current_combat
	set(value):
		_get_instance()._current_combat = value

# ======================================== controlls
static func start_combat(new_combat: Combat) -> void:
	current_combat = new_combat
	current_combat.create_enemy_formation()
	current_combat.create_sequence()
	SceneManager.change_scene(SceneManager.COMBAT_WINDOW)
	current_combat.next_turn()

# ======================================== helper
static func get_active_character() -> Character:
	return current_combat.activate_character

static func get_battle_sequence() -> Array[Character]:
	return current_combat.battle_sequence

static func get_enemy_formation() -> Array[Enemy]:
	return current_combat.enemy_formation

static func get_enemy(position: int) -> Enemy:
	return current_combat.enemy_formation[position]

static func get_hero(position: int) -> Hero:
	return current_combat.heroes[position]

static func _get_instance() -> CombatManager:
	return GameData.save_game.combat_manager
