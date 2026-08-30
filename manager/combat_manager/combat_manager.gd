extends Resource
class_name CombatManager

const COMBAT_SIZE := 3

@export_storage  var _current_combat: Combat
var _selected_combat_action : CombatAction

# ======================================== setter/getter
static var current_combat: Combat:
	get:
		return _get_instance()._current_combat
	set(value):
		_get_instance()._current_combat = value

static var selected_combat_action: CombatAction:
	get:
		return _get_instance()._selected_combat_action
	set(value):
		_get_instance()._selected_combat_action = value

# ======================================== controlls
static func start_combat(new_combat: Combat) -> void:
	current_combat = new_combat
	current_combat.create_enemy_formation()
	current_combat.create_sequence()
	SceneManager.change_scene(SceneManager.COMBAT_WINDOW)
	current_combat.next_turn()

static func select_action(action: CombatAction) -> void:
	if action == null:
		cancel_action()
		return
	if selected_combat_action == action:
		cancel_action()
		return
	selected_combat_action = action
	GlobalSignals.action_selected.emit(action)

static func select_target(target: Character) -> void:
	if selected_combat_action == null:
		return
	if not selected_combat_action.can_use(target):
		return
	var action := selected_combat_action
	action.use(target)
	selected_combat_action = null
	GlobalSignals.action_used.emit(action, target)

static func cancel_action() -> void:
	selected_combat_action = null
	GlobalSignals.action_cancelled.emit()

# ======================================== helper
static func get_active_character() -> Character:
	return current_combat.active_character

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
