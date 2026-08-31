extends Resource
class_name CombatManager

@export_storage var _enemy: Enemy

# ======================================== setter/getter
static var enemy: Enemy:
	get:
		return _get_instance()._enemy
	set(value):
		_get_instance()._enemy = value

# ======================================== controlls
static func start_combat(new_enemy: Enemy) -> void:
	if new_enemy == null:
		push_error("Cannot start combat without an enemy.")
		return
	enemy = new_enemy.duplicate(true) as Enemy
	enemy.current_hp = enemy.max_hp
	SceneManager.change_scene(SceneManager.COMBAT_WINDOW)

static func end_combat() -> void:
	enemy = null

# ======================================== helper
static func _get_instance() -> CombatManager:
	return GameData.save_game.combat_manager
