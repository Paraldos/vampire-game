extends Resource
class_name CombatManager

# ======================================== export function
@export var _current_combat: Combat

# ======================================== setter/getter
static var current_combat: Combat:
	get:
		return _get_instance()._current_combat
	set(value):
		_get_instance()._current_combat = value

# ======================================== helper
static func get_enemy_formation() -> Array[Enemy]:
	return current_combat.enemies

static func get_enemy(position: int) -> Enemy:
	return current_combat.enemies[position]

static func get_hero(position: int) -> Hero:
	return current_combat.heroes[position]

static func start_combat(new_combat: Combat) -> void:
	current_combat = new_combat
	current_combat.start()
	SceneManager.change_scene(SceneManager.COMBAT)

static func end_combat() -> void:
	current_combat = null

static func _get_instance() -> CombatManager:
	return GameData.save_game.combat_manager
